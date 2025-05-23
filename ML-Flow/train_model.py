import mlflow
import mlflow.sklearn
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.pipeline import Pipeline
from sklearn.linear_model import LogisticRegression
import pandas as pd

mlflow.set_tracking_uri("file:///tmp/mlruns")
mlflow.set_experiment("qa_llm_experiment")

data = pd.read_csv("data/qa_dataset.csv")

X = data["question"]
y = data["answer"]

model = Pipeline([
    ("tfidf", TfidfVectorizer()),
    ("clf", LogisticRegression(max_iter=1000))
])

with mlflow.start_run():
    model.fit(X, y)
    mlflow.sklearn.log_model(model, "model")
