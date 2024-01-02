org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

; FAT12 Headers

jmp short start
nop

bdb_oem: db 'MSWIN4.1'
bdb_bytes_per_sector: dw 512
bdb_sectors_per_cluster: db 1
bdb_reserved_sectors: dw 1
bdb_fat_count: db 2
bdb_dir_entries_count: dw 0E0h
bdb_total_sectors: dw 2880
bdb_media_desc_type: db 0F0h
bdb_num_sector_per_fat: dw 9
bdb_num_sectors_per_track: dw 18
bdb_heads: dw 2
bdb_hidden_sectors: dd 0
bdb_large_sectors: dd 0

; Extended boot record

ebr_drive_number: db 0
db 0
ebr_signature: db 29h
ebr_volume_id: db 16h, 32h, 48h, 64h
ebr_volume_label: db 'Makro OS'
ebr_system_id: db 'FAT12  '

start:
  jmp main

puts:
  push si
  push ax
  push bx

.loop:
  lodsb
  or al, al
  jz .done

  mov ah, 0x0E
  mov bh, 0
  int 0x10

  jmp .loop

.done:
  pop bx
  pop ax
  pop si
  ret

main:
  mov ax, 0
  mov ds, ax
  mov es, ax

  mov ss, ax
  mov sp, 0x7C00

  mov si, newYearMessage
  call puts

  hlt

.halt:
  jmp .halt

newYearMessage: db 'Happy New Years!', ENDL, 0

times 510-($-$$) db 0
dw 0AA55h