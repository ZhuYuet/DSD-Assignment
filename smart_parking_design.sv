`timescale 1ns/1ps

// UGEA2353 Digital System Design Assignment
// Smart Car Parking Controller

// Module 1: Parking FSM Controller
// Implements the nine states required by the assignment guideline.
module parking_fsm_controller (
    input  logic       clk,
    input  logic       reset,
    input  logic       car_in,
    input  logic       car_out,
    input  logic       ticket_valid,
    input  logic       payment_done,
    input  logic       parking_full,
    input  logic       parking_empty,
    output logic       gate_in,
    output logic       gate_out,
    output logic       alarm,
    output logic       display_update,
    output logic       increment_count,
    output logic       decrement_count,
    output logic [3:0] state_debug
);

    typedef enum logic [3:0] {
        IDLE            = 4'd0,
        CHECK_ENTRY     = 4'd1,
        OPEN_ENTRY_GATE = 4'd2,
        UPDATE_ENTRY    = 4'd3,
        CHECK_EXIT      = 4'd4,
        OPEN_EXIT_GATE  = 4'd5,
        UPDATE_EXIT     = 4'd6,
        PARKING_FULL    = 4'd7,
        ERROR           = 4'd8
    } state_t;

    state_t state, next_state;

    // State register with the asynchronous reset required by the guideline.
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next-state logic. When both sensors are active, exit has priority.
    always_comb begin
        next_state = state;

        case (state)
            IDLE: begin
                if (car_out)
                    next_state = CHECK_EXIT;
                else if (car_in)
                    next_state = CHECK_ENTRY;
            end

            CHECK_ENTRY: begin
                if (parking_full)
                    next_state = PARKING_FULL;
                else if (!ticket_valid)
                    next_state = ERROR;
                else
                    next_state = OPEN_ENTRY_GATE;
            end

            OPEN_ENTRY_GATE:
                next_state = UPDATE_ENTRY;

            UPDATE_ENTRY:
                next_state = IDLE;

            CHECK_EXIT: begin
                if (parking_empty || !payment_done)
                    next_state = ERROR;
                else
                    next_state = OPEN_EXIT_GATE;
            end

            OPEN_EXIT_GATE:
                next_state = UPDATE_EXIT;

            UPDATE_EXIT:
                next_state = IDLE;

            PARKING_FULL:
                next_state = IDLE;

            ERROR:
                next_state = IDLE;

            default:
                next_state = IDLE;
        endcase
    end

    // Moore output logic: outputs depend only on the current state.
    always_comb begin
        gate_in         = 1'b0;
        gate_out        = 1'b0;
        alarm           = 1'b0;
        display_update  = 1'b0;
        increment_count = 1'b0;
        decrement_count = 1'b0;

        case (state)
            OPEN_ENTRY_GATE: begin
                gate_in         = 1'b1;
                increment_count = 1'b1;
            end

            UPDATE_ENTRY: begin
                display_update = 1'b1;
            end

            OPEN_EXIT_GATE: begin
                gate_out        = 1'b1;
                decrement_count = 1'b1;
            end

            UPDATE_EXIT: begin
                display_update = 1'b1;
            end

            PARKING_FULL,
            ERROR: begin
                alarm = 1'b1;
            end

            default: begin
                // All outputs remain at their safe inactive values.
            end
        endcase
    end

    assign state_debug = state;

endmodule


// Module 2: Vehicle Counter
// Counts accepted entries/exits and prevents overflow or underflow.
module vehicle_counter #(
    parameter int unsigned MAX_CAPACITY = 10,
    parameter int unsigned COUNT_WIDTH  = 4
) (
    input  logic                   clk,
    input  logic                   reset,
    input  logic                   increment_count,
    input  logic                   decrement_count,
    output logic [COUNT_WIDTH-1:0] occupancy_count,
    output logic                   parking_full,
    output logic                   parking_empty
);

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            occupancy_count <= '0;
        end else begin
            case ({increment_count, decrement_count})
                2'b10: begin
                    if (occupancy_count < MAX_CAPACITY)
                        occupancy_count <= occupancy_count + 1'b1;
                end

                2'b01: begin
                    if (occupancy_count > 0)
                        occupancy_count <= occupancy_count - 1'b1;
                end

                default: begin
                    occupancy_count <= occupancy_count;
                end
            endcase
        end
    end

    assign parking_full  = (occupancy_count >= MAX_CAPACITY);
    assign parking_empty = (occupancy_count == 0);

endmodule


// Module 3: Display Controller
// Drives the parking-available status LED.
module display_controller (
    input  logic parking_full,
    output logic available_led
);

    always_comb begin
        available_led = !parking_full;
    end

endmodule


// Module 4: Top Module
// Integrates the FSM, counter, and display controller.
module smart_parking_top (
    input  logic clk,
    input  logic reset,
    input  logic car_in,
    input  logic car_out,
    input  logic ticket_valid,
    input  logic payment_done,
    output logic gate_in,
    output logic gate_out,
    output logic parking_full,
    output logic available_led,
    output logic alarm,
    output logic display_update
);

    logic       increment_count;
    logic       decrement_count;
    logic       parking_empty;
    logic [3:0] occupancy_count;
    logic [3:0] state_debug;

    parking_fsm_controller fsm_controller (
        .clk             (clk),
        .reset           (reset),
        .car_in          (car_in),
        .car_out         (car_out),
        .ticket_valid    (ticket_valid),
        .payment_done    (payment_done),
        .parking_full    (parking_full),
        .parking_empty   (parking_empty),
        .gate_in         (gate_in),
        .gate_out        (gate_out),
        .alarm           (alarm),
        .display_update  (display_update),
        .increment_count (increment_count),
        .decrement_count (decrement_count),
        .state_debug     (state_debug)
    );

    vehicle_counter #(
        .MAX_CAPACITY (10),
        .COUNT_WIDTH  (4)
    ) counter (
        .clk             (clk),
        .reset           (reset),
        .increment_count (increment_count),
        .decrement_count (decrement_count),
        .occupancy_count (occupancy_count),
        .parking_full    (parking_full),
        .parking_empty   (parking_empty)
    );

    display_controller display (
        .parking_full  (parking_full),
        .available_led (available_led)
    );

endmodule
