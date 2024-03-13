use core::panic;
use std::fs;
use std::env;
use std::fs::OpenOptions;
use std::path::Path;
use std::io::prelude::*;

fn pop_stack_to_d() -> String {
    "\
        // Pop to D\n\
        @SP\n\
        M=M-1\n\
        A=M\n\
        D=M\n\
        ".to_string()
}

fn go_to_stack_top() -> String {
    "\
        // Go to top of stack\n\
        @SP\n\
        A=M\n\
        A=A-1\n\
        ".to_string()
}

fn push_to_pointer(value: &str) -> String {
    format!("\
        // Get the value\n\
        @{}\n\
        D=M\n\
        @SP\n\
        M=M+1\n\
        A=M\n\
        A=A-1\n\
        M=D\n\
        ",
    value)
}

fn pop_to_pointer(value: &str) -> String {
    format!("\
        // Get the value\n\
        @SP\n\
        M=M-1\n\
        A=M\n\
        D=M\n\
        @{}\n\
        M=D\n\
        ",
    value)
}

fn handle_logical_operation(bool_num: &mut u32, command: &str) -> String {
    let mut out_string = String::new();
    if command != "not" && command != "neg" {
        out_string += &pop_stack_to_d();
    }
    out_string += &go_to_stack_top();
    out_string += "// Perform operation\n";

    let comparisons = vec!["eq", "gt", "lt"];

    if command == "add" {
        out_string.push_str("M=M+D\n"); 
    } else if command == "sub" {
        out_string.push_str("M=M-D\n"); 
    } else if command == "neg" {
        out_string.push_str("M=-M\n"); 
    } else if command == "not" {
        out_string.push_str("M=!M\n");
    } else if command == "and" {
        out_string.push_str("M=M&D\n");
    } else if command == "or" {
        out_string.push_str("M=M|D\n");
    } else if comparisons.contains(&command) {
        *bool_num += 1;
        out_string.push_str("D=M-D\n");
        out_string.push_str(&format!("@BOOL.{}\n", bool_num));
        if command == "eq" {
            out_string.push_str("D;JEQ\n");
        } else if command == "gt" {
            out_string.push_str("D;JGT\n");
        } else if command == "lt" {
            out_string.push_str("D;JLT\n");
        }

        // Go to stack
        out_string += &go_to_stack_top();

        // Set false, jump
        out_string.push_str("// Set false, jump\n");
        out_string.push_str("M=0\n");
        out_string.push_str(&format!("@BOOLJUMP.{}\n", bool_num));
        out_string.push_str("0;JMP\n");

        // Set true, continue
        out_string.push_str("// Set true, continue\n");
        out_string.push_str(&format!("(BOOL.{})\n", bool_num));
        out_string += &go_to_stack_top();
        out_string.push_str("M=-1\n");

        out_string.push_str(&format!("(BOOLJUMP.{})\n", bool_num));
        out_string.push_str("// End of comparison\n");
        out_string.push_str("@SP\n");
        //out_string.push_str("M=M-1\n");
        //out_string.push_str("0;JMP\n");


    } else {
        panic!("Unknown operation");
    }
    out_string.push_str("\n");

    out_string

}

fn handle_push_pop(command: &str, value_type: &str, value:&str) -> String {
    let mut out_string = String::new();

    if command == "push" {
        if value_type == "pointer" {
            let location = match value {
                "0" => "3",
                "1" => "4",
                _ => panic!("Unexpected symbol"),
            };
            out_string += &push_to_pointer(location);
        } else if value_type == "static" {
            let new_value = (16 + value.parse::<u32>().unwrap()).to_string();
            out_string += &push_to_pointer(&new_value);
        } else if value_type == "constant" {
            println!("  push const");
            out_string.push_str(
                &format!(
                    "\
                        // Push Constant \n\
                        @{}\n\
                        D=A\n\
                        // RAM[SP] = D \n\
                        @SP\n\
                        A=M\n\
                        M=D\n\
                        // SP++\n\
                        @SP\n\
                        M=M+1\n\
                        ",
                    value
                )); 

        } else {
            if value_type == "this" || value_type == "that" || value_type == "static"{
                out_string.push_str(
                    &format!(
                        "\
                            // Push {}\n\
                            // Go to the address and get the value \n\
                            @{}\n\
                            D=M\n\
                            @{}\n\
                            D=D+A\n\
                            A=D\n\
                            D=M\n\
                            // Push element \n\
                            @SP\n\
                            A=M\n\
                            M=D\n\
                            // Increase SP\n\
                            @SP\n\
                            M=M+1\n\
                            ",
                        value_type.to_uppercase(),
                        value_type.to_uppercase(),
                        value
                    )); 
            } else {
                let push_addr = match value_type {
                    "local" => "LCL",
                    "argument" => "ARG",
                    "this" => "THIS",
                    "that" => "THAT",
                    "temp" => "5",
                    "static" => "16",
                    _ => panic!("Unknown type"),
                };
                println!("  push non-const");
                out_string.push_str(
                    &format!(
                        "\
                            // Push {}\n\
                            @{}\n\
                            D=A\n\
                            @{}\n\
                            D=D+A\n\
                            // RAM[SP] = D \n\
                            @SP\n\
                            A=M\n\
                            M=D\n\
                            // SP++\n\
                            @SP\n\
                            M=M+1\n\
                            ",
                        push_addr,
                        push_addr,
                        value
                    )); 

            }

        }

    } else if command == "pop" {
        if value_type == "pointer" {
            let location = match value {
                "0" => "3",
                "1" => "4",
                _ => panic!("Unexpected symbol"),
            };
            out_string += &pop_to_pointer(location);
        } else if value_type == "static" {
            let new_value = (16 + value.parse::<u32>().unwrap()).to_string();
                out_string += &pop_to_pointer(&new_value);
        } else {

            let push_addr = match value_type {
                "local" => "LCL",
                "argument" => "ARG",
                "this" => "THIS",
                "that" => "THAT",
                "temp" => "5",
                _ => panic!("Unknown type"),
            };

            println!("  pop to {}", push_addr);
            out_string.push_str(
                &format!(
                    "\
                        // Get the address\n\
                        @{}\n\
                        D=M\n\
                        @R14\n\
                        M=D\n\
                        @{}\n\
                        D=A\n\
                        @R14\n\
                        M=M+D\n\
                        // Reduce stack pointer\n\
                        @SP\n\
                        M=M-1\n\
                        // Get the value\n\
                        @SP\n\
                        A=M\n\
                        D=M\n\
                        @R14\n\
                        A=M\n\
                        M=D\n\
                        ",
                    push_addr,
                    value
                )); 

        }
        }

    out_string

}


fn main() {


    let args: Vec<String> = env::args().collect();
    let in_file_path = &args[1];
    let contents = fs::read_to_string(in_file_path).expect("Could not read file.");

    let (out_filename, _filetype) = in_file_path.rsplit_once(".").unwrap();
    let out_file_path = out_filename.to_string() + ".asm";
    if Path::new(&out_file_path).exists() {
        fs::remove_file(&out_file_path).unwrap();
     }
    let mut out_file = OpenOptions::new()
        .write(true)
        .append(true)
        .create_new(true)
        .open(out_file_path)
        .unwrap();
    let mut bool_num = 0;

    let init_string = format!(
    "\
        // Init\n\
        // SP\n\
        @256\n\
        D=A\n\
        @SP\n\
        M=D\n\
        // LCL\n\
        @300\n\
        D=A\n\
        @LCL\n\
        M=D\n\
        // ARG\n\
        @400\n\
        D=A\n\
        @ARG\n\
        M=D\n\
        // THIS\n\
        @3000\n\
        D=A\n\
        @THIS\n\
        M=D\n\
        // THAT\n\
        @3010\n\
        D=A\n\
        @THAT\n\
        M=D\n\
    "
);
    if let Err(_e) = writeln!(out_file, "{}", init_string) {
        eprintln!("Could not write to file");
    }

    for mut line in contents.lines() {

        println!("{}", line);

        line = line.trim();
        if let Some((clean_line, _comment)) = line.split_once("//") {
            line = clean_line; 
        }
        line = line.trim();

        let parts: Vec<&str> = line.split(" ").collect();
        if parts.len() == 1 && parts[0] == "" {
        } else if parts.len() == 1 {
            let out_string = handle_logical_operation(&mut bool_num, line);
            if let Err(_e) = writeln!(out_file, "{}", out_string) {
                eprintln!("Could not write to file");
            }
            println!("{}", out_string);
        } else if parts.len() == 3 {
            let out_string = handle_push_pop(parts[0], parts[1], parts[2]);
            if let Err(_e) = writeln!(out_file, "{}", out_string) {
                eprintln!("Could not write to file");
            }

            println!("{}", out_string);
        } else {
            panic!("Unexpected line: {}", line)
        }

    }


}
