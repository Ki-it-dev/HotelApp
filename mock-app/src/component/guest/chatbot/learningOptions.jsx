import React, { useState, useEffect } from "react";
import axios from "axios";
import '../../../assests/css/LearningOptions.css'

const LearningOptions = (props) => {
    const [data, setData] = useState([])

    const getData = async () => {
        await axios.get('https://localhost:7023/api/Guest/GetAllCategories')
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

    //console.log(data);

    const options = data.map(item => {
        return {
            text: item.categoryName,
            handler: props.actionProvider.handleCategorys,
            id: item.categoryId,
        }
    })

    const optionsMarkup = options.map((option) => (
        <button
            className="learning-option-button"
            key={option.id}
            onClick={() => option.handler(option.id, option.text)}
        >
            {option.text}
        </button>
    ));

    return <div className="learning-options-container">{optionsMarkup}</div>;
};

export default LearningOptions;