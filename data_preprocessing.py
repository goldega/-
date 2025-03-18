from sklearn.preprocessing import StandardScaler
import joblib

def preprocess_data(data):
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(data)
    joblib.dump(scaler, 'saved_model/scaler.pkl')
    return X_scaled
