import React, { useState, useEffect } from "react";
import axios from "axios";
import '../../../assests/css/LearningOptions.css'
import { Carousel, Button, Space } from 'antd';

const AvailableBook = (props) => {
    const [data, setData] = useState([])
    console.log(data);
    const date = new Date();
    const day = date.getDate();
    const month = date.getMonth();
    const year = date.getFullYear();

    let nameCategory = sessionStorage.getItem('nameCategory')
    let today = new Date(year, month, day).toDateString("yyyy-MM-dd");
    let tomorrow = new Date(year, month, day + 1).toDateString("yyyy-MM-dd");

    let url = 'http://localhost:3000/booking/' + nameCategory

    const getData = async () => {
        await axios.get('https://localhost:7023/api/Guest/getRoomsByRoomType?roomType=' + nameCategory + '&sd=' + today + '&ed=' + tomorrow)
            .then(result => {
                setData(result.data)
            })
            .catch(error => {
                console.error(error)
            })
    }

    useEffect(() => {
        getData()
    }, []);

    const linkMarkup = data.map((item) => (
        <li key={item.roomInfo.categoryId} className="link-list-item">
            <a
                href={url}
                target="_blank"
                rel="noopener noreferrer"
                className="link-list-item-url"
            >
                <img src={item.images[0].image} width={180} height='100%' />
                <div style={{ marginLeft: 12 }}>
                    <h4 >{item.roomInfo.roomName}</h4>
                    <span className="textDropdown">
                        {item.roomInfo.description}
                    </span>
                    <Space wrap>
                        <Button type="primary" style={{ marginTop: '12px' }}>Book now</Button>
                    </Space>
                </div>
            </a>
        </li >
    ));

    return <Carousel autoplay autoplaySpeed={3000}>{linkMarkup}</Carousel>
};

export default AvailableBook;