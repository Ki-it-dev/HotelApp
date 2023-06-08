// in MessageParser.js
import React from 'react';

const MessageParser = ({ children, actions }) => {

    const parse = (message) => {
        if (message.toLowerCase().includes('hello') || message.toLowerCase().includes('hi')) {
            actions.handleHello();
        }
        if (message.toLowerCase().includes('introduce')) {
            actions.handleIntroduce();
        }
        if (message.toLowerCase().includes('paypal') || message.toLowerCase().includes('online payment') || message.toLowerCase().includes('payment')) {
            actions.handePayOnline();
        }
        if (message.toLowerCase().includes('bot')) {
            actions.handleSmallTalk('bot');
        }
        else if (message.toLowerCase().includes('friend')) {
            actions.handleSmallTalk('friend');
        }
        else if (message.toLowerCase().includes('ready')) {
            actions.handleSmallTalk('ready');
        }
        else if (message.toLowerCase().includes('real')) {
            actions.handleSmallTalk('real');
        }
        else if (message.toLowerCase().includes('busy')) {
            actions.handleSmallTalk('busy');
        }
        else if (message.toLowerCase().includes('sure')) {
            actions.handleSmallTalk('sure');
        }
        else if (message.toLowerCase().includes('there')) {
            actions.handleSmallTalk('there');
        }
        else if (message.toLowerCase().includes('clever')) {
            actions.handleSmallTalk('clever');
        }
        else if (message.toLowerCase().includes('boring')) {
            actions.handleSmallTalk('boring');
        }
        else if (message.toLowerCase().includes('help')) {
            actions.handleSmallTalk('help');
        }
        else if (message.toLowerCase().includes('goodbye')) {
            actions.handleSmallTalk('goodbye');
        }
        else if (message.toLowerCase().includes('hold')) {
            actions.handleSmallTalk('hold');
        }
        else if (message.toLowerCase().includes('how boring you are')) {
            actions.handleSmallTalk('howBoringYouAre');
        }
        else if (message.toLowerCase().includes('how is your day')) {
            actions.handleSmallTalk('YourDay');
        }
        else if (message.toLowerCase().includes('smart')) {
            actions.handleSmallTalk('smart');
        }
        else if (message.toLowerCase().includes('hug me')) {
            actions.handleSmallTalk('hugMe');
        }
        else if (message.toLowerCase().includes('fire')) {
            actions.handleSmallTalk('fire');
        }
        else if (message.toLowerCase().includes('work')) {
            actions.handleSmallTalk('work');
        }
        else if (message.toLowerCase().includes('like')) {
            actions.handleSmallTalk('like');
        }
        else if (message.toLowerCase().includes('angry')) {
            actions.handleSmallTalk('angry');
        }
        else if (message.toLowerCase().includes('back')) {
            actions.handleSmallTalk('back');
        }
        else if (message.toLowerCase().includes('insomniac')) {
            actions.handleSmallTalk('insomniac');
        }
        else if (message.toLowerCase().includes('sorry')) {
            actions.handleSmallTalk('sorry');
        }
        else if (message.toLowerCase().includes('excited')) {
            actions.handleSmallTalk('excited');
        }
        else if (message.toLowerCase().includes('love')) {
            actions.handleSmallTalk('love');
        }
        else if (message.toLowerCase().includes('talk')) {
            actions.handleSmallTalk('talk');
        }
        else if (message.toLowerCase().includes('no problem')) {
            actions.handleSmallTalk('noProblem');
        }
        else if (message.toLowerCase().includes('caring')) {
            actions.handleSmallTalk('caring');
        }
        else if (message.toLowerCase().includes('about you')) {
            actions.handleSmallTalk('aboutYou');
        }
        else if (message.toLowerCase().includes('speak')) {
            actions.handleSmallTalk('speakToMe');
        }
        else if (message.toLowerCase().includes('thank')) {
            actions.handleSmallTalk('thank');
        }
        else if (message.toLowerCase().includes('bad')) {
            actions.handleSmallTalk('bad');
        }
        else if (message.toLowerCase().includes('hobbies')) {
            actions.handleSmallTalk('hobbies');
        }
        else if (message.toLowerCase().includes('birthday')) {
            actions.handleSmallTalk('birthday');
        }
        else if (message.toLowerCase().includes('option') || message.toLowerCase().includes('category') || message.toLowerCase().includes('room')) {
            actions.handleOptions('option');
        }
        else if (message.toLowerCase().includes('booking') || message.toLowerCase().includes('book') || message.toLowerCase().includes('available')) {
            actions.handleOptions('booking');
        }
        else {
            actions.handleSmallTalk('');
        }
        
    };

    return (
        <div>
            {React.Children.map(children, (child) => {
                return React.cloneElement(child, {
                    parse: parse,
                    actions,
                })
            })}
        </div>
    );
};

export default MessageParser;