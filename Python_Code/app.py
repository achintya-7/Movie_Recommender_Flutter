from docarray import Document, DocumentArray
from jina import Flow
from helper import movies

flow = (Flow(port_expose='12345', protocol='http')
.add(
        uses="jinahub://TransformerTorchEncoder",
        uses_with={
            "pretrained_model_name_or_path":
            "sentence-transformers/paraphrase-distilroberta-base-v1"
        },
        name="encoder",
        install_requirements=True
    )
.add(
        uses="jinahub://SimpleIndexer/latest",
        uses_metas={"workspace": "workspace"},
        volumes="./workspace:/workspace/workspace",
        name="indexer")
)

# with flow as f:
#     f.post(on="/index", inputs=movies, show_progress=True)

with flow as f:
    f.post(on="/index", inputs=movies, show_progress=True)
    f.post(on="/", show_progress=True)
    f.cors = True
    f.block()
