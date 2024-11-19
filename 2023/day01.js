const fs = require('node:fs');

function reverse(str) {
  let rev = "";
  for(let i = str.length - 1; i >= 0; i--) {
    rev += str[i];
  }
  return rev;
}

const nullStr = (str) => (str === null || str === undefined) ? '' : str;

const plus = (a, b) => a + b;

const data = fs.readFileSync('./2023/inputs/day01.txt', 'utf-8');
// const data = 'two1nine\neightwothree\nabcone2threexyz\nxtwone3four\n4nineeightseven2\nzoneight234\n7pqrstsixteen';

const digits = {
  'one': 1, 
  'two': 2, 
  'three': 3, 
  'four': 4, 
  'five': 5,
  'six': 6,
  'seven': 7,
  'eight': 8, 
  'nine': 9
};

let replaced = data;

Object.entries(digits).forEach(
  ([key, value]) => {
    replaced = replaced.replace(new RegExp(key, "g"), key[0] + value + key[key.length - 1]);
  }
); 

const sum = replaced.split('\n')
  .map(str =>
    nullStr((str.match("\\d") ?? [])[0]) + nullStr((reverse(str).match("\\d") ?? [])[0])
  )
  .map(str =>  
    Number(str)
  )
  .reduce(plus);

console.log(sum);