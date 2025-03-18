from fastapi import FastAPI
import uvicorn
from model import load_model, predict_time
from database import get_data_from_db
import numpy as np

app = FastAPI()
model, scaler = load_model()

@app.post("/predict/")
def predict(weekday: int, daily_load: float):
    input_data = np.array([[weekday, daily_load]])
    recommended_time = predict_time(model, scaler, input_data)
    return {"recommended_time": recommended_time}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)
