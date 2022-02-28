const currentDate = Date.now();
const timeAndOffsetFormat = new Intl.DateTimeFormat('en-US', {
  hour: '2-digit',
  minute: '2-digit',
  timeZoneName: 'longOffset'
});
const timeAndOffset = timeAndOffsetFormat.format(currentDate);

const time = timeAndOffset.slice(0, 8);
let offset = timeAndOffset.slice(9);
