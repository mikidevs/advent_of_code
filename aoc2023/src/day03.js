const input = '467.+.114.\n...*......\n..35..633.\n......#...\n617*......\n.....+.58.\n..592.....\n......755.\n...$.*....\n.664.598..\n'

const keyValue = obj => Object.entries(obj).flat();

const last = arr => arr[arr.length - 1];

function coordObj(acc, c, i, j) {
    if(!isNaN(c) || c !== '.') {
        return [...acc, {[c]: [j, i]}]
    } else {
        return acc;
    }
}

function combineNums(numObj1, numObj2) {
    console.log("numObj1", numObj1)
    console.log("numObj2", numObj2)
    const [k1, v1] = keyValue(numObj1);
    const [k2, v2] = keyValue(numObj2);
    return { [k1 + k2]: v1.concat(v2) }
}

const mapped = input.split('\n')
    .map((str, i) => 
        Array.from(str)
            .reduce((acc, c, j) => coordObj(acc, c, i, j), [])
    );

function lastInner(acc) {
    const [_, value] = keyValue(acc[acc.length - 1]);
    const [x, __] = value.flat();
    return x;
}

console.log(mapped[0]
    .map(obj => {
        const [key, value] = keyValue(obj);
        return {[key]: [value]};
    })
    .reduce(
        (acc, curr) => {
            const [_, value] = keyValue(curr);
            if (acc.length === 0) {
                return [curr];
            }
            if (lastInner(acc) + 1 === value.flat()[0]) {
                return [combineNums(last(acc), curr)];
            }

            return [...acc, curr];
        },
        []
    )
);