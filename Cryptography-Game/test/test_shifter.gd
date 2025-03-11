extends GutTest

var Shifter = preload("res://unit-testing/caesar-shifter.gd")
var shifter

func before_each() -> void:
	shifter = Shifter.new();
	add_child(shifter);
	await get_tree().process_frame;
	
func after_each() -> void:
	shifter.queue_free();
	
#Test Case 1: Ensure wrapping logic for Caesar shift amount
func test_overflow() -> void:
	shifter.shift = 25;
	assert_eq(0, shifter.right_shift(), "Shift Amount shoult overflow to 0 when right shifted at 25");
	shifter.shift = 0;
	assert_eq(25, shifter.left_shift(), "Shift Amount shoult overflow to 25 when left shifted at 0");

#Test Case 2: Ensure shift right logic for Caesar shift decrements the string by add one
func test_right_shift() -> void:
	assert_eq("B", shifter.shift_right("A").substr(8, -1), "'A' Should become 'B' when shifted right");
	assert_eq("Q", shifter.shift_right("P").substr(8, -1), "'P' Should become 'Q' when shifted right");
	assert_eq("A", shifter.shift_right("Z").substr(8, -1), "'Z' Should become 'A' when shifted right");
	
#Test Case 3: Ensure shift left logic for Caesar shift decrements the string by add one
func test_left_shift() -> void:
	assert_eq("A", shifter.shift_left("B").substr(8, -1), "'B' Should become 'A' when shifted left");
	assert_eq("Z", shifter.shift_left("A").substr(8, -1), "'A' Should become 'Z' when shifted left");
	assert_eq("Y", shifter.shift_left("Z").substr(8, -1), "'Z' Should become 'Y' when shifted left");
