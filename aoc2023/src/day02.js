import fs from 'node:fs';
import { plus } from './utils.js';

// const data = fs.readFileSync('./2023/inputs/day02.txt', 'utf-8');
const data = 'Game 1: 4 blue, 7 red, 5 green; 3 blue, 4 red, 16 green; 3 red, 11 green\nGame 2: 20 blue, 8 red, 1 green; 1 blue, 2 green, 8 red; 9 red, 4 green, 18 blue; 2 green, 7 red, 2 blue; 10 blue, 2 red, 5 green\nGame 3: 2 red, 5 green, 1 blue; 3 blue, 5 green; 8 blue, 13 green, 2 red; 9 green, 3 blue; 12 green, 13 blue; 3 green, 3 blue, 1 red\nGame 4: 1 red, 6 green, 4 blue; 3 green, 1 blue, 1 red; 7 blue, 1 red, 2 green\nGame 5: 2 green, 9 blue, 1 red; 3 green, 1 blue, 3 red; 1 red, 4 blue, 9 green\n';

function gameToObj(str) {
    const cubes = str.split(", ");
    const obj = {};

    for(let i = 0; i < cubes.length; i++) {
        const [num, name] = cubes[i].split(" ");
        obj[name] = +num;
    }
    return obj;
}

function validGame(game) {
    return (game.red ?? 0) <= 12 && (game.green ?? 0) <= 13 && (game.blue ?? 0) <= 14;
}

// const first = data
//     .slice(0, data.length - 1)
//     .split('\n')
//     .map(game => {
//         const [gameStr, pulls] = game.split(": ");
//         const [_, gameId] = gameStr.split(" ");
//         const valid = pulls.split("; ")
//             .map(gameToObj)
//             .map(validGame)
//             .reduce((a, b) => a && b);
        
//         if (valid) {
//             return +gameId;
//         }
//     })
//     .reduce((acc, curr) => acc += (curr ?? 0));

function maxGame(acc, game) {
    const max = (f, s) => Math.max(f ?? 0, s ?? 0);
    return {
        red: max(acc.red, game.red),
        green: max(acc.green, game.green),
        blue: max(acc.blue, game.blue)
    }
}

const power = game => (game.red ?? 1) * (game.green ?? 1) * (game.blue ?? 1);

const second = data
    .slice(0, data.length - 1)
    .split('\n')
    .map(game => {
        const [_, pulls] = game.split(": ");
        const gameObjs = pulls.split("; ")
            .map(gameToObj);
        return gameObjs;
    })
    .map(gameObjs => gameObjs.reduce(maxGame))
    .map(power)
    .reduce(plus);

console.log(second);