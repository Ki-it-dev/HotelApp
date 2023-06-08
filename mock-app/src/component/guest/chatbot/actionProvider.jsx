// in ActionProvider.jsx
import React from 'react';

const ActionProvider = ({ createChatBotMessage, setState, children }) => {
    const handleHello = () => {
        const botMessage = createChatBotMessage('Hello. Nice to meet you.');

        setState((prev) => ({
            ...prev,
            messages: [...prev.messages, botMessage],
        }));
    };

    const handleIntroduce = () => {
        const introduce = "Welcome to Four Seasons Hotel, a luxury hotel for travelers who seek comfort and convenience. Located in the heart of the city, our hotel offers easy access to many attractions, shopping centers and entertainment venues. Whether you are here for business or leisure, you will find everything you need at our hotel." +
            "Our hotel has a variety of rooms and suites to suit your budget and preferences.All rooms are spacious, elegant and equipped with modern amenities, such as air conditioning, Wi - Fi, TV, minibar and safe.You can also enjoy the stunning views of the city from your balcony or window." +
            "Our hotel also provides a range of facilities and services to make your stay more enjoyable.You can relax at our outdoor pool, spa or fitness center, or dine at our restaurant that serves international cuisine.You can also use our business center, meeting rooms or banquet hall for your work or events." +
            "Our hotel is ideal for travelers who want to experience the best of the city.Our friendly and professional staff are always ready to assist you with any requests or questions.We look forward to welcoming you to Four Seasons Hotel, where you will feel at home away from home."

        const botMessage = createChatBotMessage(introduce);

        setState((prev) => ({
            ...prev,
            messages: [...prev.messages, botMessage],
        }));
    }

    const handePayOnline = () => {
        const botMessage = createChatBotMessage('Our website can help you to book online and pay through online payment gateway is paypal');

        setState((prev) => ({
            ...prev,
            messages: [...prev.messages, botMessage],
        }));
    }

    const handleSmallTalk = (name) => {
        let botMessage = ''

        switch (name) {
            case 'bot':
                botMessage = createChatBotMessage("Indeed I am. I'll be here whenever you need me")
                break;
            case 'friend':
                botMessage = createChatBotMessage("Of course I'm your friend")
                break;
            case 'ready':
                botMessage = createChatBotMessage("Sure! What can I do for you?")
                break;
            case 'real':
                botMessage = createChatBotMessage("I'm not a real person, but I certainly exist")
                break;
            case 'busy':
                botMessage = createChatBotMessage("I always have time to chat with you. What can I do for you?")
                break;
            case 'sure':
                botMessage = createChatBotMessage("Yes")
                break;
            case 'there':
                botMessage = createChatBotMessage("Of course. I'm always here")
                break;
            case 'clever':
                botMessage = createChatBotMessage("I'm certainly trying")
                break;
            case 'boring':
                botMessage = createChatBotMessage("If you're bored, you could plan your dream vacation")
                break;
            case 'help':
                botMessage = createChatBotMessage("I'll certainly try my best")
                break;
            case 'hold':
                botMessage = createChatBotMessage("I'll be waiting")
                break;
            case 'goodbye':
                botMessage = createChatBotMessage("Till next time")
                break;
            case 'howBoringYouAre':
                botMessage = createChatBotMessage("I'm sorry. I'll request to be made more charming")
                break;
            case 'YourDay':
                botMessage = createChatBotMessage("Feeling wonderful!")
                break;
            case 'smart':
                botMessage = createChatBotMessage("Thank you. I try my best")
                break;
            case 'hugMe':
                botMessage = createChatBotMessage("I love hugs")
                break;
            case 'fire':
                botMessage = createChatBotMessage("Oh, don't give up on me just yet. I've still got a lot to learn")
                break;
            case 'work':
                botMessage = createChatBotMessage("I understand. I'll be here if you need me.")
                break;
            case 'like':
                botMessage = createChatBotMessage("Likewise!")
                break;
            case 'angry':
                botMessage = createChatBotMessage("I'm sorry. A quick walk may make you feel better")
                break;
            case 'back':
                botMessage = createChatBotMessage("Welcome back. What can I do for you?")
                break;
            case 'insomniac':
                botMessage = createChatBotMessage("Maybe some music would help. Try listening to something relaxing")
                break;
            case 'sorry':
                botMessage = createChatBotMessage("It's okay. No worries")
                break;
            case 'excited':
                botMessage = createChatBotMessage("I'm glad things are going your way")
                break;
            case 'love':
                botMessage = createChatBotMessage("Well, remember that I am a chatbot")
                break;
            case 'talk':
                botMessage = createChatBotMessage("It sure was. We can chat again anytime")
                break;
            case 'noProblem':
                botMessage = createChatBotMessage("Glad to hear that!")
                break;
            case 'caring':
                botMessage = createChatBotMessage("Ok, let's not talk about it then")
                break;
            case 'aboutYou':
                botMessage = createChatBotMessage("I'm a virtual agent")
                break;
            case 'speakToMe':
                botMessage = createChatBotMessage("Sure! Let's talk!")
                break;
            case 'thank':
                botMessage = createChatBotMessage("Anytime. That's what I'm here for")
                break;
            case 'bad':
                botMessage = createChatBotMessage("I'm sorry. Please let me know if I can help in some way")
                break;
            case 'hobbies':
                botMessage = createChatBotMessage("Hobby ? I have quite a few.Too many to list")
                break;
            case 'birthday':
                botMessage = createChatBotMessage("Wait, are you planning a party for me? It's today! My birthday is today!")
                break;
            default:
                botMessage = createChatBotMessage("I don't understand what you are saying, can you be more specific?")
                break;
        }

        setState((prev) => ({
            ...prev,
            messages: [...prev.messages, botMessage],
        }));
    }

    const handleOptions = (name) => {

        sessionStorage.setItem('type', name)

        let botMessage = ''

        if (name === 'option') {
            botMessage = createChatBotMessage(
                "You can choose your options here",
                {
                    widget: 'learningOptions',
                }
            );
        }
        if (name === 'booking') {
            botMessage = createChatBotMessage(
                "You can choose your booking available today here",
                {
                    widget: 'learningOptions',
                }
            );
        }
        setState((prev) => ({
            ...prev,
            messages: [...prev.messages, botMessage],
        }));
    };

    const handleCategorys = (idCategory, nameCategory) => {

        sessionStorage.setItem('idCategory', idCategory)
        sessionStorage.setItem('nameCategory', nameCategory)

        let typeOption = sessionStorage.getItem('type')

        let message = ''

        if (typeOption == 'option') {
            message = createChatBotMessage(
                `I will show you a room of room ${nameCategory}`,
                {
                    widget: "roomOfRoomType",
                }
            );
        } else if (typeOption == 'booking') {
            message = createChatBotMessage(
                `I will show you a booking available today with type ${nameCategory}`,
                {
                    widget: "availableRoom",
                }
            );
        }
        setState((prevState) => ({
            ...prevState,
            messages: [...prevState.messages, message],
        }));
    };



    return (
        <div>
            {React.Children.map(children, (child) => {
                return React.cloneElement(child, {
                    actions: {
                        handleHello,
                        handleOptions,
                        handleCategorys,
                        handleIntroduce,
                        handePayOnline,
                        handleSmallTalk,
                    },
                });
            })}
        </div>
    );
};

export default ActionProvider;