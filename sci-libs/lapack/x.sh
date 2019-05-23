#!/bin/sh -e
export USE='cblas lapacke'
ebuild lapack-3.8.0.ebuild digest
ebuild lapack-3.8.0.ebuild clean
ebuild lapack-3.8.0.ebuild install
ebuild lapack-3.8.0.ebuild test
