use std::{collections::HashMap, fs};
use std::fs::OpenOptions;
use std::io::prelude::*;
use std::path::Path;
use std::env;

fn main() {

    let args: Vec<String> = env::args().collect();
    println!("{:?}", args[1]);

    let file_path = &args[1];
    // This will not work with a dot in the file name
    let (path, _extension) = file_path.rsplit_once(".").unwrap(); 
    println!("{}", path);
    let out_file = path.to_string() + ".hack";

    
    let contents = fs::read_to_string(file_path)
        .expect("Could not read file.");
    if Path::new(&out_file).exists() {
        fs::remove_file(&out_file).unwrap();
    }
    let mut file = OpenOptions::new()
        .write(true)
        .append(true)
        .create_new(true)
        .open(out_file)
        .unwrap();


    let mut comp_lut: HashMap<String, u16> = HashMap::new();
    comp_lut.insert("0".to_string(),   0b0101010);
    comp_lut.insert("1".to_string(),   0b0111111);
    comp_lut.insert("-1".to_string(),  0b0111010);
    comp_lut.insert("D".to_string(),   0b0001100);
    comp_lut.insert("A".to_string(),   0b0110000);
    comp_lut.insert("M".to_string(),   0b1110000);
    comp_lut.insert("!D".to_string(),  0b0001101);
    comp_lut.insert("!A".to_string(),  0b0110001);
    comp_lut.insert("!M".to_string(),  0b1110001);
    comp_lut.insert("-D".to_string(),  0b0001111);
    comp_lut.insert("-A".to_string(),  0b0110011);
    comp_lut.insert("-M".to_string(),  0b1110011);
    comp_lut.insert("D+1".to_string(), 0b0011111);
    comp_lut.insert("A+1".to_string(), 0b0110111);
    comp_lut.insert("M+1".to_string(), 0b1110111);
    comp_lut.insert("D-1".to_string(), 0b0001110);
    comp_lut.insert("A-1".to_string(), 0b0110010);
    comp_lut.insert("M-1".to_string(), 0b1110010);
    comp_lut.insert("D+A".to_string(), 0b0000010);
    comp_lut.insert("D+M".to_string(), 0b1000010);
    comp_lut.insert("D-A".to_string(), 0b0010011);
    comp_lut.insert("D-M".to_string(), 0b1010011);
    comp_lut.insert("A-D".to_string(), 0b0000111);
    comp_lut.insert("M-D".to_string(), 0b1000111);
    comp_lut.insert("D&A".to_string(), 0b0000000);
    comp_lut.insert("D&M".to_string(), 0b1000000);
    comp_lut.insert("D|A".to_string(), 0b0010101);
    comp_lut.insert("D|M".to_string(), 0b1010101);

    let mut dest_lut: HashMap<String, u16> = HashMap::new();
    dest_lut.insert("0".to_string(), 0b000);
    dest_lut.insert("M".to_string(),    0b001);
    dest_lut.insert("D".to_string(),    0b010);
    dest_lut.insert("MD".to_string(),   0b011);
    dest_lut.insert("A".to_string(),    0b100);
    dest_lut.insert("AM".to_string(),   0b101);
    dest_lut.insert("AD".to_string(),   0b110);
    dest_lut.insert("AMD".to_string(),  0b111);

    let mut jump_lut: HashMap<String, u16> = HashMap::new();
    jump_lut.insert("null".to_string(), 0b000);
    jump_lut.insert("JGT".to_string(),  0b001);
    jump_lut.insert("JEQ".to_string(),  0b010);
    jump_lut.insert("JGE".to_string(),  0b011);
    jump_lut.insert("JLT".to_string(),  0b100);
    jump_lut.insert("JNE".to_string(),  0b101);
    jump_lut.insert("JLE".to_string(),  0b110);
    jump_lut.insert("JMP".to_string(),  0b111);

    let mut symbol_table: HashMap<String, u16> = HashMap::new();
    symbol_table.insert("SP".to_string(),   0x0000);
    symbol_table.insert("LCL".to_string(),  0x0001);
    symbol_table.insert("ARG".to_string(),   0x0002);
    symbol_table.insert("THIS".to_string(),   0x0003);
    symbol_table.insert("THAT".to_string(),   0x0004);
    symbol_table.insert("R0".to_string(),   0x0000);
    symbol_table.insert("R1".to_string(),   0x0001);
    symbol_table.insert("R2".to_string(),   0x0002);
    symbol_table.insert("R3".to_string(),   0x0003);
    symbol_table.insert("R3".to_string(),   0x0003);
    symbol_table.insert("R3".to_string(),   0x0003);
    symbol_table.insert("R4".to_string(),   0x0004);
    symbol_table.insert("R5".to_string(),   0x0005);
    symbol_table.insert("R6".to_string(),   0x0006);
    symbol_table.insert("R7".to_string(),   0x0007);
    symbol_table.insert("R8".to_string(),   0x0008);
    symbol_table.insert("R9".to_string(),   0x0009);
    symbol_table.insert("R10".to_string(),   0x000a);
    symbol_table.insert("R11".to_string(),   0x000b);
    symbol_table.insert("R12".to_string(),   0x000c);
    symbol_table.insert("R13".to_string(),   0x000d);
    symbol_table.insert("R14".to_string(),   0x000e);
    symbol_table.insert("R15".to_string(),   0x000f);
    symbol_table.insert("SCREEN".to_string(),   0x4000);
    symbol_table.insert("KBD".to_string(),   0x6000);


    let mut potential_variables: Vec<String> = Vec::new();
    let mut labels: Vec<(String, u32)> = Vec::new();
    let mut line_number: u32 = 0;

    println!("First Pass");
    for line in contents.lines() {
        println!("{:<6}{}", line_number, line);

        // If there is noting on the line
        if line.is_empty() { continue; }
        // If the line is a comment
        if line.trim_start()[0..2] == "//".to_string() { continue; }


        if line.trim_start().chars().nth(0).unwrap() == '@' { // A-type
            //print!("  AT: ");

            let symbol = &line.trim()[1..];
            if let Ok(_) = symbol.parse::<u32>() { // If it is not an address
                //println!("ADDRESS");
            } else {
                if !potential_variables.contains(&symbol.to_string()) 
                && !symbol_table.contains_key(&symbol.to_string()) {
                    //println!("SYMBOL: {}", symbol.to_string());
                    potential_variables.push(symbol.to_owned().to_string());
                }
            }
            line_number += 1;
        } else if line.chars().nth(0).unwrap() == '(' { // Label
            //println!("  LABEL");
            let mut chars = line.trim().chars();
            chars.next();
            chars.next_back();
            let symbol = chars.as_str();
            
                //println!("SYMBOL: {}", symbol.to_string());
            labels.push((symbol.to_owned().to_string(), line_number));
        } else {
            line_number += 1;
        }

    }


    println!("");
    println!("Variables:");
    let mut var_num = 0;
    potential_variables.sort();
    for variable in potential_variables.iter() {

        println!("{}", variable);
        if !symbol_table.contains_key(&variable.to_string()) {
            symbol_table.insert(variable.to_string(), var_num + 15);
            var_num += 1;
        }
    }
    println!("");

    println!("Labels: ");
    for label in &labels {
        let (name, line_num) = label;
        println!("{}", name);
        symbol_table.insert(name.to_string(), *line_num as u16);
    }
    println!("");

    println!("Table: ");
    for (key, value) in &symbol_table {
        print!("{:<30}", key);
        println!("{:<15}", value);
    }

    for line in contents.lines() {
        //println!("{}", line);
        // If there is noting on the line
        if line.is_empty() { continue; }
        // If the line is a comment
        if line.trim_start()[0..2] == "//".to_string() { continue; }

        let mut out_line: u16 = 0x0000; // The converted line to output

        if line.trim_start().chars().nth(0).unwrap() == '@' { // A-type
            
            let symbol = &line.trim()[1..];
            if let Ok(num) = symbol.parse::<u16>() { // If it is not an address
                //println!("{}", num);
                out_line |= num; 
            } else {
                if let Some(addr) = symbol_table.get(symbol) {
                    //println!("  addr: {}", addr);
                    out_line |= addr; 
                } else {
                    //panic!("Unimplemented");
                }
            }
            //println!("  Out line: {:#016b}", out_line);
            let out_line_string = format!("{:016b}", out_line);
            if let Err(e) = writeln!(file, "{}", out_line_string) {
                eprintln!("Couldn't write to file: {}", e);
            }

        } else if line.chars().nth(0).unwrap() == '(' { // Label: Ignore
        } else {
            out_line |= 0xE000;
            if let Some((dest, mut rest)) = line.split_once("=") {
                //print!("  Dest: {:10} \n", dest);
                if let Some((l, _comment)) = rest.split_once("//") {
                    rest = l.trim();
                }
                //print!("  Rest: [{}]\n", rest);
                if let Some((comp, jump)) = rest.split_once(";") {
                    out_line |= comp_lut.get(comp).unwrap() << 6;
                    out_line |= dest_lut.get(dest).unwrap() << 3;
                    out_line |= jump_lut.get(jump).unwrap();
                } else {
                    out_line |= comp_lut.get(rest.trim()).unwrap() << 6;
                    out_line |= dest_lut.get(dest.trim()).unwrap() << 3;
                }
                //println!("  Out line: {:#016b}", out_line);

            } else {
                let (comp, mut jump) = line.split_once(";").unwrap();
                //println!("  Comp: [{}] Jump: [{}]", comp, jump);
                if let Some((l, _comment)) = jump.split_once("//") {
                    jump = l.trim();
                }
                out_line |= comp_lut.get(comp.trim()).unwrap() << 6;
                out_line |= jump_lut.get(jump.trim()).unwrap();

                
            } 

            let out_line_string = format!("{:016b}", out_line);
            if let Err(e) = writeln!(file, "{}", out_line_string) {
                eprintln!("Couldn't write to file: {}", e);
            }

        }

    }








}
