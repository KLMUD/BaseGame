package net.nander.botproject.integrations

import net.nander.botproject.Bot
import org.luaj.vm2.LuaValue
import org.luaj.vm2.lib.OneArgFunction
import org.luaj.vm2.lib.ThreeArgFunction
import org.luaj.vm2.lib.TwoArgFunction
import org.telegram.telegrambots.api.methods.send.SendMessage
import java.util.concurrent.TimeUnit


/**
 * Basic interfacing with Telegram API.
 */
@Suppress("unused", "ClassName")
class Telegram : TwoArgFunction() {

    /**
     * Loads the Telegram module
     * @param moduleName which module-name to load it as
     * @param env which environment to load
     */
    override fun call(moduleName: LuaValue, env: LuaValue?): LuaValue {
        val library = LuaValue.tableOf()
        library.set("sendMessage", sendMessage())
        library.set("sendReplyMessage", sendReplyMessage())
        library.set("getNextMessage", getNextMessage())
        env!!.set("telegram", library)
        return library
    }

    /**
     * Sends a message to a certain chat-ID
     */
    internal class sendMessage : TwoArgFunction() {
        /**
         * Sends a message
         * @param id lua-value of the chatID
         * @param message lua-value of the text of the message-to-be-sent
         * @return Nil
         */
        override fun call(id: LuaValue?, message: LuaValue?): LuaValue {
            Bot.server!!.execute(SendMessage(id!!.tolong(), message.toString()).enableMarkdown(true))
            return LuaValue.NIL
        }
    }

    /**
     * Sends a message as a reply to a certain message.
     */
    internal class sendReplyMessage : ThreeArgFunction() {
        /**
         * Sends a message
         * @param id lua-value of the chatID
         * @param replyTo lua-value of the messageID of the message to reply to
         * @param message lua-value of the text of the message-to-be-sent
         * @return Nil
         */
        override fun call(id: LuaValue?, replyTo: LuaValue?, message: LuaValue?): LuaValue {
            val reply = replyTo!!.toint()
            Bot.server!!.execute(SendMessage(id!!.tolong(), message.toString()).setReplyToMessageId(reply).enableMarkdown(true))
            return LuaValue.NIL
        }
    }

    /**
     * Gets the next message from the message-queue
     */
    internal class getNextMessage : OneArgFunction() {
        /**
         * Sends a message
         * @param millis lua-value of the time to poll.
         * @return Nil
         */
        override fun call(millis: LuaValue?): LuaValue {
            if (millis != null) {
                val msg = Bot.messageQueue.poll(millis.tolong(), TimeUnit.MILLISECONDS) ?: return LuaValue.NIL
                val json = Bot.gson.toJson(msg)
                return LuaValue.valueOf(json)
            }
            return LuaValue.NIL
        }
    }
}