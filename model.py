import tensorflow as tf
from tensorflow import keras
from tensorflow.keras.layers import Dense, Dropout, BatchNormalization
import numpy as np
import joblib
from data_preprocessing import preprocess_data

def train_model(X_train, y_train):
    model = keras.Sequential([
        Dense(64, activation='relu', input_shape=(X_train.shape[1],)),
        BatchNormalization(),
        Dropout(0.2),
        Dense(128, activation='relu'),
        Dropout(0.3),
        Dense(64, activation='relu'),
        Dense(1, activation='sigmoid')
    ])
    model.compile(optimizer='adam', loss='mean_squared_error', metrics=['mae'])
    model.fit(X_train, y_train, epochs=50, batch_size=32, validation_split=0.2)
    model.save('saved_model/booking_model.h5')

def load_model():
    model = keras.models.load_model('saved_model/booking_model.h5')
    scaler = joblib.load('saved_model/scaler.pkl')
    return model, scaler

def predict_time(model, scaler, input_data):
    input_scaled = scaler.transform(input_data)
    prediction = model.predict(input_scaled)
    return float(prediction[0][0])
