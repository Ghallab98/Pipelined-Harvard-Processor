const fs = require('fs')

//take file name from arguments
const filename = process.argv[2];
//load the file
const data = fs.readFileSync(filename).toString();

//name of new File
const newFile = filename.split('.')[0] + '.mem'

//lines of the asm file
let lines = data.split(/(\r\n|\r|\n)/)

//config of the memory instruction

let newFileLines = ['MEMORY DATA FILE',
    'ALL INSTRUCTIONS WITHOUT IMMEDIATE ADDRESS OR OFFSET ARE WRITTEN IN A SINGLE LINE',
    'INSTRUCTIONS WITH IMM ADDRESS OR OFFSET ARE WRITTEN ON 2 CONSECUTIVE LINES']

//remove empty lines and comments
lines = lines.filter(line => !line.match(/^(\s+)/))
lines = lines.filter(line => line != '')
lines = lines.filter(line => !line.match(/^#/))
lines = lines.filter(line => !line.match(/(\r\n|\r|\n)/))
let linesWritten = 0

for (let i = 0; i < lines.length; i++) {
    const command = lines[i].split(/(\s+)/).filter(function (e) { return e.trim().length > 0; })[0].toLowerCase()
    const commandData = lines[i].split(/(\s+)/).filter(function (e) { return e.trim().length > 0; })[1]

    let newLine = ''
    let regs = ''
    let effectiveAdd = ''
    let reg = ''
    switch (command) {
        /*case '.org':
            for (let j = linesWritten; j < convertToDecimal(commandData); j++) {
                newFileLines.push('0000000000000000')
                linesWritten++;
            }
            if (lines[i + 1].match(/^[0-9]/)) {
                let address = convertToBin(convertToDecimal(lines[++i]))
                newFileLines.push(address.slice(16))
                linesWritten++;
                newFileLines.push(address.slice(0, 16))
                linesWritten++;
            }
            break;*/
        //--One Operand
        case 'nop':
            linesWritten++
            newFileLines.push('0000000000000000')
            break;
        case 'setc':
            linesWritten++
            newFileLines.push('0000100000000000')
            break;
        case 'clrc':
            linesWritten++
            newFileLines.push('0001000000000000')
            break;
        case 'not':
            linesWritten++
            newLine = '00011' + registerDecode(commandData) + '00000000'
            newFileLines.push(newLine)
            break;
        case 'inc':
            linesWritten++;
            newLine = '00100' + registerDecode(commandData) + '00000000'
            newFileLines.push(newLine)
            break;
        case 'dec':
            linesWritten++
            newLine = '00101' + registerDecode(commandData) + '00000000'
            newFileLines.push(newLine)
            break;
        case 'out':
            linesWritten++
            newLine = '00110' + registerDecode(commandData) + '00000000'
            newFileLines.push(newLine)
            break;
        case 'in':
            linesWritten++
            newLine = '00111' + registerDecode(commandData) + '00000000'
            newFileLines.push(newLine)
            break;
        //--Two Operad
        case 'mov':
            linesWritten++
            regs = commandData.split(',')
            newLine = '01000' + registerDecode(regs[1]) + registerDecode(regs[0]) +'00000';
            newFileLines.push(newLine)
            break;
        case 'add':
            linesWritten++
            regs = commandData.split(',')
            newLine = '01001' + registerDecode(regs[1]) + registerDecode(regs[0]) + '00000';
            newFileLines.push(newLine)
            break;
        //TODO::
        case 'iadd':
            linesWritten++;
            regs = commandData.split(',')
            newLine = '01010' + registerDecode(regs[0]) + "00000000";
            newFileLines.push(newLine)
            newFileLines.push(convertToBin(convertToDecimal(regs[1])).slice(16))
            linesWritten++
            break;
        case 'sub':
            linesWritten++
            regs = commandData.split(',')
            newLine = '01011' + registerDecode(regs[1]) + registerDecode(regs[0]) + '00000';
            newFileLines.push(newLine)
            break;
        case 'and':
            linesWritten++
            regs = commandData.split(',')
            newLine = '01100' + registerDecode(regs[1]) + registerDecode(regs[0]) + '00000';
            newFileLines.push(newLine)
            break;
        case 'or':
            linesWritten++
            regs = commandData.split(',')
            newLine = '01101' + registerDecode(regs[1]) + registerDecode(regs[0]) + '00000';
            newFileLines.push(newLine)
            break;
        case 'shl':
            linesWritten++;
            regs = commandData.split(',')
            newLine = '01110' + registerDecode(regs[0]) + "00000000";
            newFileLines.push(newLine)
            newFileLines.push(convertToBin(convertToDecimal(regs[1])).slice(16))
            linesWritten++
            break;
        case 'shr':
            linesWritten++;
            regs = commandData.split(',')
            newLine = '01111' + registerDecode(regs[0]) + "00000000";
            newFileLines.push(newLine)
            newFileLines.push(convertToBin(convertToDecimal(regs[1])).slice(16))
            linesWritten++
            break;
        //--Memory
        case 'push':
            linesWritten++
            newLine = '10000' + registerDecode(commandData) +'00000000';
            newFileLines.push(newLine)
            break;
        case 'pop':
            linesWritten++
            newLine = '10001' + registerDecode(commandData) +'00000000';
            newFileLines.push(newLine)
            break;
        case 'ldm':
            linesWritten++;
            regs = commandData.split(',')
            newLine = '10010' + registerDecode(regs[0]) + "00000000";
            newFileLines.push(newLine)
            newFileLines.push(convertToBin(convertToDecimal(regs[1])).slice(16))
            linesWritten++
            break;
        case 'ldd':
            linesWritten++
            regs = commandData.split(','); //r2 , 200(r5)
            regsNew = regs[1].split('(');   //200 , r5)
            regsNew[1]= regsNew[1].substring(0, regsNew[1].length - 1); // 200 ,r5
            newLine = '10011' + registerDecode(regs[0]) +registerDecode(regsNew[1]) + "00000";
            newFileLines.push(newLine)
            effectiveAdd = convertToBin(convertToDecimal(regsNew[0]));
            effectiveAdd= effectiveAdd.substr(effectiveAdd.length-16,effectiveAdd.length-1);
            newFileLines.push(effectiveAdd)
            linesWritten++
            break;
        case 'std':
            linesWritten++
            regs = commandData.split(','); //r2 , 200(r5)
            regsNew = regs[1].split('(');   //200 , r5)
            regsNew[1]= regsNew[1].substring(0, regsNew[1].length - 1); // 200 ,r5
            newLine = '10100' + registerDecode(regs[0]) +registerDecode(regsNew[1]) + "00000";
            newFileLines.push(newLine)
            effectiveAdd = convertToBin(convertToDecimal(regsNew[0]));
            effectiveAdd= effectiveAdd.substr(effectiveAdd.length-16,effectiveAdd.length-1);
            newFileLines.push(effectiveAdd)
            linesWritten++
            break;
    }
}

fs.writeFileSync(newFile,newFileLines.join('\n'))


function convertToDecimal(data){

    return parseInt('0x'+data)
}
function convertToBin(hex){
    let binData = ''
    for( let i = 0 ; i< 32; i++){
        if(Math.floor(hex%2)===1){
            binData= '1'+ binData
        }else{
            binData = '0'+ binData
        }
        hex = hex/2;

    }

    return binData
}
function registerDecode(reg){
    let regVal 
    switch(reg.toUpperCase()){
        case 'R0':
            regVal='000'
            break;
        case 'R1':
            regVal='001'
            break;
        case 'R2':
            regVal='010'
            break;
        case 'R3':
            regVal='011'
            break;
        case 'R4':
            regVal='100'
            break;
        case 'R5':
            regVal='101'
            break;
        case 'R6':
            regVal='110'
            break;
        case 'R7':
            regVal='111'
            break;
    }

    return regVal;
}