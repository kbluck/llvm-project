/*===- AVRxxTarget.td - AVRxx Target Machine Description --*- tablegen -*-===*

  Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
  See https://llvm.org/LICENSE.txt for license information.
  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

  To build these sources interactively, first switch to the current folder
  where this file is located.

  cd {path_to_llvm-project}/llvm/lib/Target/AVRxx

  Basic Compile:
  llvm-tblgen -I ../../../include -print-records AVRxxTarget.td

  Compile and filter only the AVRxx definitions from the output.
  Assumes def blocks end with a curly brace on its own line.
  llvm-tblgen -I ../../../include -print-records AVRxxTarget.td | sed -n '/def.*AVRxx/, /^\s*}/p'

  Generate Register Info:
  llvm-tblgen -I ../../../include -gen-register-info -register-info-debug AVRxxTarget.td

  Test Register Info with lit:
  lit .
-*===---------------------------------------------------------------------===*/

include "llvm/Target/Target.td"


/*===--------------------------- Define devices --------------------------===*/

//include "AVRDevices.td" 


/*===------------------------ Define Register Info -----------------------===*/

//include "AVRxxRegisterInfo.td"


/*===----------------------- Define instruction set ----------------------===*/

//include "AVRInstrInfo.td" 
def AVRxxInstrInfo : InstrInfo;


/*===--------------------- Define calling conventions --------------------===*/

//include "AVRCallingConv.td" 


/*===------------------ Define assembly parser and writer ----------------===*/

def AVRxxAsmParser : AsmParser {
  let ShouldEmitMatchRegisterName = 1;
  let ShouldEmitMatchRegisterAltName = 1;
}

def AVRxxAsmParserVariant : AsmParserVariant {
  int Variant = 0;

  // Recognize hard coded registers.
  string RegisterPrefix = "$";
  string TokenizingCharacters = "+";
}

def AVRxxAsmWriter : AsmWriter {
  string AsmWriterClassName = "InstPrinter";
  bit isMCAsmWriter = 1;
}

/*===--------------------------- Declare target --------------------------===*/
def AVRxxTarget : Target {
  let InstructionSet = AVRxxInstrInfo;

  let AssemblyWriters        = [ AVRxxAsmWriter ];
  let AssemblyParsers        = [ AVRxxAsmParser ];
  let AssemblyParserVariants = [ AVRxxAsmParserVariant ];
}
