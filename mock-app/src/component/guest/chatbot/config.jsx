// in config.js
import { createChatBotMessage } from 'react-chatbot-kit';

import LearningOptions from './learningOptions';
import LinkList from './linkList';
import AvailableBook from './availableBook';

const botName = 'FourSeasonsBot';

const config = {
    initialMessages: [createChatBotMessage(`Hi! I'm ${botName}, How can I help you?`)],
    botName: botName,
    customStyles: {
        botMessageBox: {
            backgroundColor: '#376B7E',
        },
        chatButton: {
            backgroundColor: '#5ccc9d',
        },
    },
    widgets: [
        {
            widgetName: "learningOptions",
            widgetFunc: (props) => <LearningOptions {...props} />,
        },
        {
            widgetName: "roomOfRoomType",
            widgetFunc: (props) => <LinkList {...props} />,
        },
        {
            widgetName: 'availableRoom',
            widgetFunc: (props) => <AvailableBook {...props} />,
        }
    ],
};

export default config;