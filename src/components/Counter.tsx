import React, { useState } from 'react';

type CounterProps = {
  label: string;
};

const Counter: React.FC<CounterProps> = ({ label }) => {
  const [count, setCount] = useState<number>(0);

  const increment = () => {
    setCount(prev => prev + 1);
    console.log(`${label} increment`, count + 1);
  };

  return (
    <div>
      <h3>{label}: {count}</h3>
      <button onClick={increment}>+1</button>
    </div>
  );
};

export default Counter;
