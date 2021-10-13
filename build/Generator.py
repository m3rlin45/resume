import click
import json

from jinja2 import Environment, select_autoescape, FileSystemLoader
from filters import add_filters


@click.group()
def cli():
    pass

@cli.command()
@click.argument("json_resume", type=click.File("r"))
@click.argument("template_path")
@click.argument("output_file", type=click.File("w"))
def generate_html(json_resume, template_path, output_file):

    resume_data = json.load(json_resume)

    env = Environment(loader=FileSystemLoader("./"), autoescape=select_autoescape())
    add_filters(env)
    env.get_template(template_path).stream(resume_data).dump(output_file)


@cli.command()
@click.argument("json_resume", type=click.File("r"))
@click.argument("template_path")
@click.argument("output_file", type=click.File("w"))
def generate_latex(json_resume, template_path, output_file):
    resume_data = json.load(json_resume)

    env = Environment(
        loader=FileSystemLoader("./"),
        autoescape=False,
        block_start_string="<%",
        block_end_string="%>",
        variable_start_string="<$",
        variable_end_string="$>",
        comment_start_string="<#",
        comment_end_string="#>",
    )
    add_filters(env)
    env.get_template(template_path).stream(resume_data).dump(output_file)
    
if __name__ == "__main__":
    cli()
