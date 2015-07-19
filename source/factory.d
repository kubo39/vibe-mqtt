﻿/**
 * 
 * /home/tomas/workspace/mqtt-d/source/factory.d
 * 
 * Author:
 * Tomáš Chaloupka <chalucha@gmail.com>
 * 
 * Copyright (c) 2015 ${CopyrightHolder}
 * 
 * Boost Software License 1.0 (BSL-1.0)
 * 
 * Permission is hereby granted, free of charge, to any person or organization obtaining a copy
 * of the software and accompanying documentation covered by this license (the "Software") to use,
 * reproduce, display, distribute, execute, and transmit the Software, and to prepare derivative
 * works of the Software, and to permit third-parties to whom the Software is furnished to do so,
 * all subject to the following:
 * 
 * The copyright notices in the Software and this entire statement, including the above license
 * grant, this restriction and the following disclaimer, must be included in all copies of the Software,
 * in whole or in part, and all derivative works of the Software, unless such copies or derivative works
 * are solely in the form of machine-executable object code generated by a source language processor.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
 * PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR ANYONE
 * DISTRIBUTING THE SOFTWARE BE LIABLE FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */
module mqttd.factory;

import std.string : format;
import mqttd.message;

void serialize(T)(T msg, scope void delegate(ubyte) sink)
{
    //set remaining packet length
    msg.setRemainingLength;

    //check if is valid
    try msg.checkPacket();
    catch (Exception ex) throw new PacketFormatException(format("'%s' packet is not valid: %s", T.stringof, ex.msg));

    msg.toBytes(sink);
}

unittest
{
    import std.array;

    auto con = Connect();

    auto buffer = appender!(byte[]);

    serialize(con, a => buffer.put(a));
}
