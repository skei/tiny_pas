#!/bin/bash

strip -R .note \
      -R .comment \
      -R .eh_frame \
      -R .eh_frame_hdr \
      -s intro

./sstrip intro

