import { createReadStream, createWriteStream } from "fs"
import readline from "readline"
import axios from "axios"

const fileStream = createReadStream("data.csv")
const rl = readline.createInterface({
  input: fileStream,
  crlfDelay: Infinity
})

const lineCount = 318303
let i = 0

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms))

const output = createWriteStream("output-2.csv")
const header = `"Date","Niveau","Allonge","Assis","SessionID","formattedDate","Serie","Vie"`
output.write(header + "\n")

for await (const line of rl) {
  i++
  if (line.startsWith('"Date"')) continue
  const [Date, Niveau, Allonge, Assis, SessionID] = line.split(",").map((x) => x.trim().replace(/"/g, ""))

  const timestamp = parseInt(Date)
  const level = isNaN(parseInt(Niveau)) ? 0 : parseInt(Niveau)
  const lying = Allonge === "True"
  const seating = Assis === "True"
  const sessionId = SessionID

  const data = await axios.post("http://localhost:3000", { sessionId, date: timestamp, level, lying, seating }).then(res => res.data)
  const [serial, life] = data.split(",")
  output.write(line + `,"${serial}","${life}"\n`)
  
  process.stdout.write(`\rProcessing line (${lineCount}) : ${i}`);
}