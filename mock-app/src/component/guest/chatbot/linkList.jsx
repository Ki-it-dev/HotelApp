import React, { useState, useEffect } from "react";
import axios from "axios";
import { } from 'antd';
import { Carousel, Button, Space } from 'antd';

import '../../../assests/css/LinkList.css'

const LinkList = (props) => {
    let idCategory = sessionStorage.getItem('idCategory')
    let url = 'http://localhost:3000/booking/' + sessionStorage.getItem('nameCategory')

    const [data, setData] = useState([])
    const getData = async () => {
        await axios.get('https://localhost:7023/api/Guest/GetAllRoomCategories/' + idCategory)
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
        <li key={item.roomId} className="link-list-item">
            <a
                href={url}
                target="_blank"
                rel="noopener noreferrer"
                className="link-list-item-url"
            >
                <img src={item.image} width={180} height='100%' />
                <div style={{ marginLeft: 12 }}>
                    <h4 >{item.roomName}</h4>
                    <span className="textDropdown">
                        {item.description}
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

export default LinkList;