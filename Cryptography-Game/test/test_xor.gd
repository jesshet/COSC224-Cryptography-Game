extends GutTest

var XOR = preload("res://unit-testing/xor-decrypt-tool-test.gd");
var xor;

func before_each() -> void:
	xor = XOR.new();
	add_child(xor);
	await get_tree().process_frame;
	
func after_each() -> void:
	xor.queue_free();
	
func test_xor() -> void:
	assert_eq("68656C6C6F",xor._xor_testing("ABCD123456", "C3A87E5839"))
	assert_eq("68656C6C6F",xor._xor_testing("C3A87E5839", "ABCD123456"))
	assert_eq("FFFFFFFFFF",xor._xor_testing("FFFFFFFFFF", "0000000000"))
	assert_eq("0000000000",xor._xor_testing("FFFFFFFFFF", "FFFFFFFFFF"))
	assert_eq("0000000000",xor._xor_testing("0000000000", "0000000000"))
