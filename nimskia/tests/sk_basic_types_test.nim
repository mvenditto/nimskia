import unittest

import ../nimskia/[
  sk_imageinfo,
  sk_rect,
  sk_point,
  sk_enums
]

suite "skia basic types":

  test "image info methods do not modify source":
    let info = newImageInfo(100, 30, Rgb565, Unpremul, nil)

    check(info.colorType == Rgb565)

    let copy = info.withColorType(Gray8)

    check(info.colorType == Rgb565)
    check(copy.colorType == Gray8)

  test "rectangle has correct properties":
    let rect = newRect(15.0 , 25.0, 55.0, 75.0)

    check(15f == rect.left)
    check(25f == rect.top)
    check(55f == rect.right)
    check(75f == rect.bottom)

    check(40f == rect.width)
    check(50f == rect.height)

    check(35f == rect.midX)
    check(50f == rect.midY)

  test "rectangle offsets correctly":
    let expected = newRect(25.0, 30.0, 65.0, 80.0)

    let rect1 = newRect(15.0 , 25.0, 55.0, 75.0)
    rect1.location = newPoint(25.0, 30.0)

    var rect2 = newRect(15.0 , 25.0, 55.0, 75.0)
    rect2.offset(10, 5)

    check(expected == rect1)
    check(expected == rect2)

  test "rectangle inflates correctly":
    let rect = newRect(15.0, 25.0, 55.0, 75.0)

    check(15f == rect.left)
    check(25f == rect.top)
    check(55f == rect.right)
    check(75f == rect.bottom)

    rect.inflate(10, 20)

    check(5f == rect.left)
    check(5f == rect.top)
    check(65f == rect.right)
    check(95f == rect.bottom)

  test "rectangle standardize correctly":
    let rect = newRect(5.0, 5.0, 15.0, 15.0)
    check(rect.width == 10)
    check(rect.height == 10)

    check(rect == rect.standardized())

    let negW = newRect(15.0, 5.0, 5.0, 15.0)
    check(-10.0 == negW.width)
    check(10.0 == negW.height)
    check(rect == negW.standardized)

    let negH = newRect(5.0, 15.0, 15.0, 5.0)
    check(10.0 == negH.width)
    check(-10.0 == negH.height)
    check(rect == negH.standardized)

    let negWH = newRect(15.0, 15.0, 5.0, 5.0)
    check(-10.0 == negWH.width)
    check(-10.0 == negWH.height)
    check(rect == negWH.standardized)

