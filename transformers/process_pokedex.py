if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test

PROCESSED_POKEDEX_COLS = [
    "ID",
    "Name",
    "Type1",
    "Type2",
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
    Performs the appropriate processing steps on the Pokedex dataframe.

    Args:
        data: The output from the upstream parent block
        args: The output from any additional upstream blocks (if applicable)

    Returns:
        A dataframe containing the processed pokedex data
    """
    data.rename(
        columns={"#": "ID"},
        inplace=True
    )

    data["Name"] = data["Name"].map(clean_pokemon_name)
    
    data[["Type1", "Type2"]] = data["Type"].str.split(n=1, expand=True)
    data["Type2"] = data["Type2"].fillna("")
    data.drop(columns=["Type"], inplace=True)

    data["internal_id"] = range(1, len(data) + 1)

    return data


def clean_pokemon_name(name):
    name = name.split()

    if len(name) > 1:
        return " ".join(name[1:])

    return name[0]


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output.isnull().sum().sum() == 0, "Null values found!"
    assert set(PROCESSED_POKEDEX_COLS).issubset(output.columns), "Incorrect columns!"