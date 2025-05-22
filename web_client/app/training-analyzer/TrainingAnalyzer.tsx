"use client";

import React, { useEffect, useState } from "react";
import "./traininganalyzer.css"; // Add styles for the heatmap

const TrainingAnalyzer: React.FC = () => {
    const [data, setData] = useState<number[][]>([]);

    useEffect(() => {
        // Generate random data for 52 weeks (52 x 7 grid)
        const generateRandomData = () => {
            const weeks = 52;
            const daysPerWeek = 7;
            const randomData: number[][] = [];

            for (let i = 0; i < weeks; i++) {
                const weekData: number[] = [];
                for (let j = 0; j < daysPerWeek; j++) {
                    weekData.push(Math.floor(Math.random() * 121)); // Random value between 0 and 120
                }
                randomData.push(weekData);
            }

            return randomData;
        };

        setData(generateRandomData());
    }, []);

    const getColor = (value: number): string => {
        if (value === 0) return "#e0e0e0"; // Light gray for no activity
        if (value <= 30) return "#c6e48b"; // Light green
        if (value <= 60) return "#7bc96f"; // Medium green
        if (value <= 90) return "#239a3b"; // Dark green
        return "#196127"; // Darkest green
    };

    return (
        <div className="heatmap">
            {data.map((week, weekIndex) => (
                <div key={weekIndex} className="week">
                    {week.map((day, dayIndex) => (
                        <div
                            key={dayIndex}
                            className="day"
                            style={{ backgroundColor: getColor(day) }}
                            title={`Day ${weekIndex * 7 + dayIndex + 1}: ${day} minutes`}
                        ></div>
                    ))}
                </div>
            ))}
        </div>
    );
};

export default TrainingAnalyzer;