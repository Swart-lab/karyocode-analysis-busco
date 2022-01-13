# If rules are split across multiple snakefiles, list them here
# include: "rules-A"
# include: "rules-B"

WD="/ebio/abt2_projects/ag-swart-karyocode/analysis/busco"

rule all:
    input:
        expand("busco_out/{lib}/short_summary.specific.alveolata_odb10.{lib}.txt", lib=config['proteins_shortlist'])

rule busco:
    input:
        lambda wildcards: config['proteins_shortlist'][wildcards.lib]
    output:
        "busco_out/{lib}/short_summary.specific.alveolata_odb10.{lib}.txt"
    conda: "envs/busco.yml"
    log: "logs/busco.{lib}.log"
    threads: 16
    shell:
        "busco -m protein -i {input} -l alveolata_odb10 -f --cpu {threads} -o {wildcards.lib} --out_path busco_out &> {log};"
