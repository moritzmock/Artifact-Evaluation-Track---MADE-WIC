import pandas as pd

if __name__ == "__main__":
    data = pd.read_json("devign.json")
    data = data[data["project"] == "qemu"]
    data = data.sample(n=100, random_state=42)
    data.to_json("devign_sample.json", index=False, orient='records')
