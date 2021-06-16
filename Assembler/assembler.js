const fs = require('fs')

//take file name from arguments
const filename = process.argv[2];
//load the file
const data = fs.readFileSync(filename).toString();

//name of new File
const newFile = filename.split('.')[0] + '.mem'

//lines of the asm file
let lines = data.split(/(\r\n|\r|\n)/)
let size=0;

//config of the memory instruction

let newFileLines = []

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
            newFileLines.push(linesWritten.toString(16)+': 0000000000000000')
            break;
        case 'setc':
            linesWritten++
            newFileLines.push(linesWritten.toString(16)+': 0000100000000000')
            break;
        case 'clrc':
            linesWritten++
            newFileLines.push(linesWritten.toString(16)+': 0001000000000000')
            break;
        case 'not':
            newLine = linesWritten.toString(16)+': 00011' + registerDecode(commandData) + '00000000'
            linesWritten++
            newFileLines.push(newLine)
            break;
        case 'inc':
            newLine = linesWritten.toString(16)+': 00100' + registerDecode(commandData) + '00000000'
            linesWritten++;
            newFileLines.push(newLine)
            break;
        case 'dec':
            newLine = linesWritten.toString(16)+': 00101' + registerDecode(commandData) + '00000000'
            linesWritten++
            newFileLines.push(newLine)
            break;
        case 'out':
            newLine = linesWritten.toString(16)+': 00110' + registerDecode(commandData) + '00000000'
            linesWritten++
            newFileLines.push(newLine)
            break;
        case 'in':
            newLine = linesWritten.toString(16)+': 00111' + registerDecode(commandData) + '00000000'
            linesWritten++
            newFileLines.push(newLine)
            break;
        //--Two Operad
        case 'mov':
            regs = commandData.split(',')
            newLine = linesWritten.toString(16)+': 01000' + registerDecode(regs[1]) + registerDecode(regs[0]) +'00000';
            linesWritten++
            newFileLines.push(newLine)
            break;
        case 'add':
            regs = commandData.split(',')
            newLine = linesWritten.toString(16)+': 01001' + registerDecode(regs[1]) + registerDecode(regs[0]) + '00000';
            linesWritten++
            newFileLines.push(newLine)
            break;
        case 'iadd':
            regs = commandData.split(',')
            newLine = linesWritten.toString(16)+': 01010' + registerDecode(regs[0]) + "00000000";
            linesWritten++;
            newFileLines.push(newLine)
            newFileLines.push(linesWritten.toString(16)+': '+convertToBin(convertToDecimal(regs[1])).slice(16))
            linesWritten++
            break;
        case 'sub':
            regs = commandData.split(',')
            newLine = linesWritten.toString(16)+': 01011' + registerDecode(regs[1]) + registerDecode(regs[0]) + '00000';
            linesWritten++
            newFileLines.push(newLine)
            break;
        case 'and':
            regs = commandData.split(',')
            newLine = linesWritten.toString(16)+': 01100' + registerDecode(regs[1]) + registerDecode(regs[0]) + '00000';
            linesWritten++
            newFileLines.push(newLine)
            break;
        case 'or':
            regs = commandData.split(',')
            newLine = linesWritten.toString(16)+': 01101' + registerDecode(regs[1]) + registerDecode(regs[0]) + '00000';
            linesWritten++
            newFileLines.push(newLine)
            break;
        case 'shl':
            regs = commandData.split(',')
            newLine = linesWritten.toString(16)+': 01110' + registerDecode(regs[0]) + "00000000";
            linesWritten++;
            newFileLines.push(newLine)
            newFileLines.push(linesWritten.toString(16)+': '+convertToBin(convertToDecimal(regs[1])).slice(16))
            linesWritten++
            break;
        case 'shr':
            regs = commandData.split(',')
            newLine = linesWritten.toString(16)+': 01111' + registerDecode(regs[0]) + "00000000";
            newFileLines.push(newLine)
            linesWritten++;
            newFileLines.push(linesWritten.toString(16)+': '+convertToBin(convertToDecimal(regs[1])).slice(16))
            linesWritten++
            break;
        //--Memory
        case 'push':
            newLine = linesWritten.toString(16)+': 10000' + registerDecode(commandData) +'00000000';
            linesWritten++
            newFileLines.push(newLine)
            break;
        case 'pop':
            newLine = linesWritten.toString(16)+': 10001' + registerDecode(commandData) +'00000000';
            linesWritten++
            newFileLines.push(newLine)
            break;
        case 'ldm':
            regs = commandData.split(',')
            newLine = linesWritten.toString(16)+': 10010' + registerDecode(regs[0]) + "00000000";
            linesWritten++;
            newFileLines.push(newLine)
            newFileLines.push(linesWritten.toString(16)+': '+convertToBin(convertToDecimal(regs[1])).slice(16))
            linesWritten++
            break;
        case 'ldd':
            regs = commandData.split(','); //r2 , 200(r5)
            regsNew = regs[1].split('(');   //200 , r5)
            regsNew[1]= regsNew[1].substring(0, regsNew[1].length - 1); // 200 ,r5
            newLine = linesWritten.toString(16)+': 10011' + registerDecode(regs[0]) +registerDecode(regsNew[1]) + "00000";
            linesWritten++
            newFileLines.push(newLine)
            effectiveAdd = convertToBin(convertToDecimal(regsNew[0]));
            effectiveAdd= effectiveAdd.substr(effectiveAdd.length-16,effectiveAdd.length-1);
            newFileLines.push(linesWritten.toString(16)+': '+effectiveAdd)
            linesWritten++
            break;
        case 'std':
            regs = commandData.split(','); //r2 , 200(r5)
            regsNew = regs[1].split('(');   //200 , r5)
            regsNew[1]= regsNew[1].substring(0, regsNew[1].length - 1); // 200 ,r5
            newLine = linesWritten.toString(16)+': 10100' + registerDecode(regs[0]) +registerDecode(regsNew[1]) + "00000";
            linesWritten++
            newFileLines.push(newLine)
            effectiveAdd = convertToBin(convertToDecimal(regsNew[0]));
            effectiveAdd= effectiveAdd.substr(effectiveAdd.length-16,effectiveAdd.length-1);
            newFileLines.push(linesWritten.toString(16)+': '+effectiveAdd)
            linesWritten++
            break;
    }
}

let tempLines=linesWritten
for (let i=tempLines ; i<4095 ; i++){
    linesWritten++;
    newFileLines.push(i.toString(16)+": XXXXXXXXXXXXXXXX")

}
console.log(linesWritten)

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