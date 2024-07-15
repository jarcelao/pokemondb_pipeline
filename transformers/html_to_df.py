if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

from bs4 import BeautifulSoup
import pandas as pd

RAW_POKEDEX_COLS = [
    "#",
    "Name",
    "Type",
    "Total",
    "HP",
    "Attack",
    "Defense",
    "Sp. Atk",
    "Sp. Def",
    "Speed"
]


@transformer
def transform(data, *args, **kwargs):
    """
    Extracts the Pokemon list from the website and loads it into a Dataframe.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        A Dataframe containing the raw data from the pokemondb site
    """
    soup = BeautifulSoup(data, "html.parser")

    pokedex_html = str(soup.find(id="pokedex"))
    pokedex_df = pd.read_html(pokedex_html)[0]

    return pokedex_df


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, "Failed to load DataFrame!"
    assert set(RAW_POKEDEX_COLS).issubset(output.columns), "Incorrect columns!"
