if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

import requests
TARGET_URL = 'https://pokemondb.net/pokedex/all'


@data_loader
def load_data(*args, **kwargs):
    """
    Makes a request to the pokemondb website.

    Returns:
        Raw response from the website.
    """
    response = requests.get(TARGET_URL)
    return response.text


@test
def test_output(output, *args) -> None:
    """
    Tests if the website data was successfully scraped.
    """
    assert output is not None or output != "", 'Failed to load HTML!'
