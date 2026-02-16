project(
    'project-tests',
    module_dir: '.',
)

fs = import('fs')

muon_path = get_option('muon')
if muon_path == ''
    error('please specify path to muon repo')
endif

muon_path = meson.current_source_dir() / muon_path

if not fs.is_dir(muon_path)
    error('invalid path to muon repo: "@0@"'.format(muon_path))
endif

image_tgt = custom_target(
    output: 'image',
    command: [
        'docker',
        'build',
        '-t', get_option('image_tag'),
        '-f', files('Dockerfile'),
        muon_path,
    ],
    build_by_default: true,
    build_always_stale: true,
    console: true,
)

import('generate').generate(dependencies: [image_tgt])
