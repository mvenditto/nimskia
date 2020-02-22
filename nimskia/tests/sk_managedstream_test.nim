import unittest

import ../nimskia/sk_stream
import ../nimskia/sk_managedstream
import ../nimskia/internals/exceptions

import os
import oids
import strformat
import streams


suite "SkManagedStream test":
  
  test "Nim stream is closed":
    var strm = newStringStream("test")
    var managed = newSkManagedStream(strm, true)
    check(strm.getPosition() == 0)
    managed.dispose()
    when defined(nimNoNilSeqs):
      check(strm.data == "")
    else:
      check(isNil strm.data)

  test "Nim stream is NOT closed":
    var strm = newStringStream("test")
    var managed = newSkManagedStream(strm, false)
    check(strm.getPosition() == 0)
    managed.dispose()
    when defined(nimNoNilSeqs):
      check(strm.data != "")
    else:
      check(not isNil strm.data)

  test "ManagedStream reads correctly":

    var x: string = ""
    for i in 0..255: x = x & chr(i)

    let strm = newStringStream(x)
    let managed = newSkManagedStream(strm)

    check(managed.rewind())
    check(managed.getPosition() == 0)
    check(strm.getPosition() == 0)

    for i in 0..255:
      check(managed.seek(i))
      check(managed.getPosition() == i)
      check(i == ord(x[i]))
      check(i.uint8 == managed.readUByte())
      check(i + 1 == managed.getPosition())
      check(i + 1 == strm.getPosition())

    check(managed.rewind())
    check(managed.getPosition() == 0)
    check(strm.getPosition() == 0)

  test "ManagedStream reads chunks correctly":
    let strm = newStringStream("abcd")
    let managed = newSkManagedStream(strm)

    check(managed.rewind())
    check(managed.getPosition() == 0)
    check(strm.getPosition() == 0)

    var buff = [0.byte, 0, 0, 0]
    let readBytes = managed.read(buff.addr, 4)
    check(readBytes == 4)
    for i in 0..3: 
      check(buff[i] == (97 + i).byte)

  test "ManagedStream reads offset chunks correctly":
    let strm = newStringStream("nimabcd")
    let managed = newSkManagedStream(strm)

    check(managed.rewind())
    check(managed.getPosition() == 0)
    check(strm.getPosition() == 0)

    check(managed.move(3))

    var buff = [0.byte, 0, 0, 0]
    let readBytes = managed.read(buff.addr, 4)
    check(readBytes == len(strm.data) - 3)
    check(readBytes == 4)
    for i in 0..3:
      check(buff[i] == (97 + i).byte)

  test "stream can be duplicated but original stream cannot be read anymore":
    let strm = newStringStream("abcdef")
    let managed = newSkManagedStream(strm, true)
    check(managed.readByte() == ord('a'))
    check(managed.readByte() == ord('b'))
    check(managed.readByte() == ord('c'))
    let dupe = managed.duplicate()
    check(dupe != managed)
    check(dupe.readByte() == ord('a'))
    check(dupe.readByte() == ord('b'))
    check(dupe.readByte() == ord('c'))
    expect InvalidOperationError:
      discard managed.readByte()
    managed.dispose()

  test "stream can be forked but original stream cannot be read anymore":
    let strm = newStringStream("abcdef")
    let managed = newSkManagedStream(strm, true)
    check(managed.readByte() == ord('a'))
    check(managed.readByte() == ord('b'))
    let fork = managed.fork()
    check(fork != managed)
    check(fork.readByte() == ord('c'))
    check(fork.readByte() == ord('d'))
    expect InvalidOperationError:
      discard managed.readByte()
    managed.dispose()

  test "ManagedStream cannot be duplicated multiple times":
    let strm = newStringStream("abcdef")
    let managed = newSkManagedStream(strm, true)
    check(managed.readByte() == ord('a'))
    check(managed.readByte() == ord('b'))
    let dupe = managed.duplicate()
    expect InvalidOperationError:
      discard managed.duplicate()
    check(dupe.readByte() == ord('a'))

  test "stream can be duplicated multiple times if the child is destroyed":
    let strm = newStringStream("abcdef")

    let managed = newSkManagedStream(strm, true)
    check(managed.readByte() == ord('a'))
    check(managed.readByte() == ord('b'))

    let dupe1 = managed.duplicate()
    check(dupe1.readByte() == ord('a'))
    check(dupe1.readByte() == ord('b'))
    
    dupe1.dispose()

    let dupe2 = managed.duplicate()
    check(dupe2.readByte() == ord('a'))
    check(dupe2.readByte() == ord('b'))

    expect InvalidOperationError:
      discard managed.duplicate()