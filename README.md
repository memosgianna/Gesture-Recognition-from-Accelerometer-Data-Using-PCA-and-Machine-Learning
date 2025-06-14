# Gesture Recognition Project

This repository provides all the necessary resources to perform gesture recognition using accelerometer data. The workflow covers data acquisition, preprocessing, dimensionality reduction, model training, and evaluation.

## Data Collection

Gestures were performed in a controlled manner for clarity and consistency. Specifically, 10 sets of 10 repetitions were recorded for each of the letters **A** and **L** using an accelerometer.

---

## Notebooks Overview

### 1. `aiot_dataset_creation.ipynb`

- Connects to a MongoDB database
- Uploads raw CSV files containing gesture data
- Ensures data is available for downstream processing

### 2. `aiot_project.ipynb`

- Loads gesture data from the database
- Visualizes raw data (time-domain plots, 3D plots)
- Applies preprocessing: filtering, segmentation, flattening
- Splits data into training and testing sets
- Scales features using Min-Max normalization
- Performs PCA for dimensionality reduction (2 and 3 components)
- Trains classifiers (e.g., Logistic Regression)
- Evaluates models using accuracy, F1-score, and confusion matrix

---

## Running the Project

### Prerequisites

- Python 3.8 or newer
- MongoDB installed and running
- Jupyter Notebook or Jupyter Lab
- Required Python libraries (install via `requirements.txt`)

### Step 1: Start MongoDB and Jupyter Services

- Start MongoDB:  
    ```bash
    sudo systemctl start mongod
    ```
- Start Jupyter Lab:  
    ```bash
    jupyter lab
    ```

#### (Optional) Using Docker

- Start Docker daemon:  
    ```bash
    sudo dockerd
    ```
- Launch MongoDB and Jupyter containers:  
    ```bash
    ./start_project.sh
    ```

### Step 2: Install Python Dependencies

- In a terminal or Jupyter cell, run:  
    ```bash
    pip install -r requirements.txt
    ```

### Step 3: Configure the Database

Update the database connection settings as needed:

- **MongoDB URI:**  
    `mongodb://mymongo:27017`
- **Database name:**  
    `aiot_course`
- **Collection name:**  
    `gesture_data`

### Step 4: Run the Notebooks

1. Open and execute all cells in `aiot_dataset_creation.ipynb` to upload and prepare the data.
2. Open and execute all cells in `aiot_project.ipynb` to process the data, train models, and evaluate results.

---

## Notes

- Ensure MongoDB is running before executing the notebooks.
- Adjust database connection parameters if your setup differs.
- For reproducibility, use the provided `requirements.txt` to install dependencies.

---