let fs = require('fs');

const getWaitingTimeForBus = (busID) => {
    const mod = timestamp % busID;
    if (mod === 0) {
        return 0;
    }
    return busID - mod;
}

const fileData = fs.readFileSync('./input', {encoding:'utf8', flag:'r'});
let [timestamp, busses] = fileData.split("\n");

timestamp = Number(timestamp);
busses = busses.split(",")
               .filter(x => x !== "x")
               .map(Number);

let bestBus = busses[0];
let shortestWaitingTime = getWaitingTimeForBus(bestBus);

for (let i = 1; i < busses.length; ++i) {
    const waitingTime = getWaitingTimeForBus(busses[i]);
    if (waitingTime < shortestWaitingTime) {
        shortestWaitingTime = waitingTime;
        bestBus = busses[i];
    }
}

console.log(bestBus * shortestWaitingTime);
