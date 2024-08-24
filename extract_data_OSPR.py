import argparse
import random
import os
from tqdm import tqdm
import pandas as pd


def load_df_with_progress(path):
    tqdm.pandas()
    chunk_size = 10000
    df = pd.concat([chunk for chunk in tqdm(pd.read_csv(path, chunksize=chunk_size), desc="Loading DataFrame")])
    return df


def read_args():
    parser = argparse.ArgumentParser()

    parser.add_argument("--path-repo", required=True, type=str)
    parser.add_argument("--path-dataset", required=True, type=str)

    return parser.parse_args()


def read_file(path):
    with open(path, 'r') as file:
        content = file.read()
    return content


def write_file(path, content):
    with open(path, "w") as file:
        # Write the content to the file
        file.write(content)


def check_and_create_path(path):
    folders = path.split('/')
    current_path = ""

    for folder in folders[0:len(folders)-1]:
        if folder == "":
            continue

        current_path = os.path.join(current_path, folder)

        if not os.path.exists(current_path):
            os.makedirs(current_path)


if __name__ == "__main__":
    args = read_args()
    print(args)

    data = load_df_with_progress(args.path_dataset)

    data = data[data["Projectname"] == "Chromium"]

    data = data["Filepath"].unique().tolist()
    random.seed(42)
    random.shuffle(data)
    data = data[0:50]

    for path in data:
        filepath_old = "{}/{}".format(args.path_repo, path)
        filepath_new = "{}/{}".format("chromium_sample", path)
        content = read_file(filepath_old)
        check_and_create_path(filepath_new)
        write_file(filepath_new, content)



