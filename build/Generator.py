import click
import json

from jinja2 import Environment, select_autoescape, FileSystemLoader
from filters import add_filters



@click.command()
@click.argument("json_resume", type=click.File("r"))
@click.argument("template_path")
@click.argument("output_file", type=click.File("w"))
def generate_html(json_resume, template_path, output_file):

    resume_data = json.load(json_resume)

    env = Environment(loader=FileSystemLoader("./"), autoescape=select_autoescape())
    add_filters(env)
    env.get_template(template_path).stream(resume_data).dump(output_file)

    
if __name__ == "__main__":
    generate_html()
