for I in $(find . -type f -name '*.ebuild'); do
	ebuild $I digest
done
