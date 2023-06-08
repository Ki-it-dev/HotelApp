import { useState } from 'react';
import Chatbot from 'react-chatbot-kit'
import 'react-chatbot-kit/build/main.css';

import config from './config';
import ActionProvider from './actionProvider';
import MessageParser from './messageParser';

import '../../../assests/css/chat.css'

import { MessageTwoTone } from '@ant-design/icons';

export default function MainChat() {

    const [showBot, toggleBot] = useState(false);
    const loadMessages = () => {
        const messages = JSON.parse(localStorage.getItem('chat_messages'));
        return messages;
    };

    const validator = (input) => {
        if (!input.replace(/\s/g, '').length) {
            return false;
        }
        if (input.length > 1) {
            return true;
        }
        return false
    }

    return (
        <div className='App'>
            <>
                {showBot && (
                    <Chatbot
                        config={config}
                        actionProvider={ActionProvider}
                        messageHistory={loadMessages()}
                        saveMessages={(messages) => localStorage.setItem('chat_messages', JSON.stringify(messages))}
                        messageParser={MessageParser}
                        validator={validator}
                    />
                )}
                <MessageTwoTone style={{ fontSize: 50 }} className='fixedButton' onClick={() => toggleBot((prev) => !prev)} />
            </>
        </div>
    );
}