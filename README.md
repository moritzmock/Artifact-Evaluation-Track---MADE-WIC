# Instructions

## Setup

With the following commands the evaluation of the replication package needs to be setup.

```
git@github.com:moritzmock/Artifact-Evaluation-Track---MADE-WIC.git
cd Artifact-Evaluation-Track---MADE-WIC
curl -L "https://zenodo.org/records/12567874/files/MADE-WIC.zip?download=1" -o "MADE-WIC.zip"
unzip MADE-WIC.zip
```


## Sample data (optional step)

In the following section, the creation of the sample data is described. It does not neccessariliy need to be redone, since we provide the created sample. However, for transparency, we provide also those scripts.

### Creating the sample for devign (qemu part)
```
curl -L "https://drive.google.com/uc?id=1x6hoF7G-tSYxg8AFybggypLZgMGDNHfF" -o devign.json
python -m venv env
source env/bin/activate
pip install -r req.txt
python extract_data_devign.py
```

### Creating the sample for OSPR (chromium part)
```
git clone git@github.com:chromium/chromium.git chromium
cd chromium
git checkout 57f97b2
cd ..
python extract_data_OSPR.py --path-repo chromium --path-dataset MADE-WIC/Dateset/OSPR/complete.csv
```

## Docker 

It is assumed that Docker is up and running at the local machine.
With the following command the process can be started.

```
docker build -t aet . && docker run --name aet_c aet
```

Once the docker container was created successfully, the data can be extracted with the commands.

```
docker cp aet_c:/MADE-WIC/Replication/Devign_made-wic.csv .
docker cp aet_c:/MADE-WIC/Replication/OSPR_made-wic.csv .
```

And lastly the created image and container can be deleted with the commands

```
docker rm aet_c
docker rmi aet
```

# Paper

This repository contains the data used for the Artifact Evaluation Track of ASE for the paper `MADE-WIC: Multiple Annotated Datasets for Exploring Weaknesses In Code` which is accepted at the ASE'24 Tool and Demonstration Track. The preprint is already [available](https://arxiv.org/abs/2408.05163).

```bibtex
@misc{mock2024madewicmultipleannotateddatasets,
      title={MADE-WIC: Multiple Annotated Datasets for Exploring Weaknesses In Code}, 
      author={Moritz Mock and Jorge Melegati and Max Kretschmann and Nicolás E. Díaz Ferreyra and Barbara Russo},
      year={2024},
      eprint={2408.05163},
      archivePrefix={arXiv},
      primaryClass={cs.SE},
      url={https://arxiv.org/abs/2408.05163}, 
}
```
