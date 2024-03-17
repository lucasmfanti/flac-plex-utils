# flac-plex-utils

Welcome to flac-plex-utils! This repository contains a series of PowerShell scripts designed to enhance your experience with FLAC files on your Plex Music Server.

## About Plex

[Plex](https://www.plex.tv/) is a powerful media server platform that allows you to organize, stream, and share your personal media collections, including music, movies, TV shows, photos, and more. With Plex, you can access your media library from anywhere with an internet connection, making it an ideal solution for hosting your own personal music server.

## Why FLAC Files?

FLAC (Free Lossless Audio Codec) is a popular audio format known for its high-quality sound and efficient compression. Unlike lossy formats like MP3, FLAC files preserve all the original audio data, ensuring that you experience your music as intended by the artist. This makes FLAC an excellent choice for storing your music library, especially if you value audio fidelity.

## Metaflac and Metadata

[Metaflac](https://xiph.org/flac/documentation_tools_metaflac.html) is a command-line utility for manipulating FLAC file metadata. Metadata, such as artist name, album title, track number, and more, provides valuable information about a song or album. Metaflac allows you to view, edit, and manipulate this metadata, enabling you to organize and manage your music library with precision.

## Folder Architecture for Plex Music Server

To organize your music library for a Plex Music Server, it's recommended to follow a specific folder structure. Here's an example of the folder architecture:

```plaintext
\Music
    \Artist A
        \Album 1
        \Album 2
    \Artist B
        \Album 1
        \Album 2
        \Album 3

In this structure:
- The root folder is named "Music."
- Each artist has a separate folder named after them.
- Within each artist folder, individual albums are organized in their respective subfolders.
- Each album subfolder contains the songs belonging to that album.

This hierarchical organization allows Plex to accurately index and display your music library, making it easy to navigate and enjoy your favorite tunes.

## Scripts

### Rename Song Title with Comments

This script renames the title of a song to include comments about it. It's useful for adding additional context or information to your music library.

### Rename Files with Disc and Track Numbers

This script renames FLAC files following the pattern: disc number + track number - song title. This standardized naming convention makes it easier to organize and manage your music collection in a Plex server.

### Create Lyrics Files

This script generates lyrics files for each song in your library in a way your Plex server can locate them. Lyrics files can enhance your listening experience by providing lyrics while you're playing music.

### Generate Album Cover JPEG

This script generates a JPEG file for the cover of an album from the associated metadata in the files. Having album artwork associated with your music adds visual appeal to your library and makes browsing more enjoyable.

### Quick Script for Album Enhancement

This script combines the functionalities of the previous scripts to automate the process of enhancing a particular album from an artist. It streamlines the workflow, making it convenient to apply multiple enhancements in one go.

## Usage

To use these scripts, simply download or clone this repository to your local machine. Make sure you have PowerShell installed. Then, navigate to the directory containing the scripts and execute them using PowerShell.

Enjoy having an automated way of organizing your personal music library!