<h1 align="center">Utkarsh's Portfolio</h1>

> Welcome to my personal portfolio website. This site showcases my projects, blog posts, and other professional activities.

![Website](/public/README/website.png)

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Directory Structure](#directory-structure)
- [Customization](#customization)
- [Contributing](#contributing)

## Installation

### Prerequisites

- [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
- [Jekyll](https://jekyllrb.com/docs/installation/)
- [Bundler](https://bundler.io/)

### Clone the Repository

```bash
git clone https://github.com/pro-utkarshM/blogs.git
cd blogs
```

### Install Dependencies

```bash
bundle install
```

## Usage

### Local Development

To start a local server and view the website:

```bash
bundle exec jekyll serve
```

Open your browser and navigate to `http://localhost:4000` to see the website.

### Building the Site

To build the site for production:

```bash
bundle exec jekyll build
```

The output will be in the `_site` directory.

## Directory Structure

```plaintext
.
├── 404.html
├── about.md
├── atom.xml
├── commit.sh
├── _config.yml
├── Gemfile
├── Gemfile.lock
├── index.html
├── LICENSE
├── _posts
│   ├── 2023-12-31-networking.md
│   ├── 2024-02-11-Kernel-1.1.md
│   ├── .
│   ├── .
│   ├── .
│   ├── 2024-06-03-VLANs
│   └── _site
│       ├── 2024-02-11-Kernel-1.1.html
│       ├── .
│       ├── .
│       ├── .
│       └── 2024-05-22-snake-game.html
├── public
│   ├── avatar.jpg
│   └── media
│       ├── Network-design-01.png
│       ├── Network-design-02.png
│       ├── Network-design-03.png
│       ├── role-of-kernel.png
│       ├── terminal.png
│       └── thread_info_stack.png
├── README.md
└── _site

39 directories, 121 files
```

## Customization

- **Navigation**: Update `_config.yml` to modify navigation links.
- **Styling**: Customize CSS files in the `assets/css` directory to change the look and feel of the website.
- **Content**: Update markdown files in the `_posts` directory to add your own blog posts.
- **Images**: Replace images in the `public/media` directory with your own.
- **Favicon**: Replace `favicon.png` in the `assets` directory with your own favicon.

## Contributing

If you'd like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/improvement`).
3. Make your changes.
4. Commit your changes (`git commit -am 'Add new feature'`).
5. Push to the branch (`git push origin feature/improvement`).
6. Create a new Pull Request.

---

Feel free to reach out if you have any questions or suggestions!
