import express from "express"
import { z } from "zod"

const Payload = z.object({
  sessionId: z.string(),
  // date: z.coerce.date(),
  date: z.number().transform((val) => new Date(val * 1000)),
  level: z.number().int().min(0).max(2),
  seating: z.boolean(),
  lying: z.boolean()
})
const UserDay = z.object({
  date: z.string(),
  practice: z.boolean(),
  life: z.number(),
  serial: z.number(),
  training: z.object({
    lying: z.number(),
    seating: z.number(),
  }),
})

/** @type {Map<string, z.infer<typeof UserDay>[]>} */
const users = new Map()
const app = express()

/** @param {z.infer<typeof UserDay>[]} days */
const calculate = (days) => {
  const day = days[days.length - 1]
  let life = days[days.length - 2]?.life ?? 2
  let serial = days[days.length - 2]?.serial ?? 0
  
  if (!day.practice && life <= 0) {
    life = 2
    serial = 0
  } else if (!day.practice && serial > 0) life--
  else if (day.practice) {
    serial++
    const last4Days = days.slice(-5, -1)
    if (last4Days.every((d) => d.practice && d.life === life)) life = Math.min(2, life + 1)
  }

  return { serial, life }
}

/** @param {z.infer<typeof Payload>} data */
const getSerial = ({ sessionId, date: d, level, seating, lying }, ignorePrevious = false) => {
  const dYear = d.getFullYear()
  const dMonth = (d.getMonth() + 1).toString().padStart(2, "0")
  const dDay = d.getDate().toString().padStart(2, "0")
  const date = `${dYear}-${dMonth}-${dDay}`

  const days = users.get(sessionId) || []

  const haveDay = days.at(-1)?.date === date
  const previousDay = haveDay ? days.at(-2) : days.at(-1)
  const day = haveDay ? days.at(-1) : UserDay.parse({ date, practice: false, life: 0, serial: 0, training: { lying: 0, seating: 0 } })

  if (previousDay && !ignorePrevious) {
    const delta = Math.floor((d.setHours(0, 0, 0, 0) - new Date(previousDay.date).setHours(0, 0, 0, 0)) / 86400000)
    if (delta > 1) {
      for (let i = 1; i < delta; i++) {
        const date = new Date(new Date(previousDay.date).getTime() + i * 86400000)
        getSerial({
          sessionId,
          date,
          level: 0,
          seating: false,
          lying: false
        }, true)
      }
    }
  }

  day.training.lying = Math.min(2, (day.training.lying + (lying ? level : 0)))
  day.training.seating = Math.min(2, (day.training.seating + (seating ? level : 0)))
  day.practice = day.training.lying === 2 && day.training.seating === 2

  if (!days.includes(day)) days.push(day)
  const { life, serial } = calculate(days)
  day.life = life
  day.serial = serial

  users.set(sessionId, days.sort((a, b) => a.date.localeCompare(b.date)))
  return { serial, life }
}

app.use(express.json())
app.delete("/", (req, res) => {
  users.clear()
  res.status(204).send()
})
app.post("/", (req, res) => {
  const payload = Payload.parse(req.body)
  const { serial } = getSerial(payload)

  res.send(serial.toString())
})

app.listen(3000, () => {
  console.log("Server is running on port 3000")
})