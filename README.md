# WP Site Replicator

**Quickly create replicas of large production websites from WordPress eXtended RSS (WXR) export files.**

## Usage

- This command relies on writing directly to the WP database via WP DB API so both post and term tables should be empty.

- All existing users with the same login name will be deleted and new users created with a random password because WordPress export doesn't include the passwords. All users will need to reset their passwords. Use `wp user update USERNAME --user_pass="YOURNEWPASSWORD"` to update a password for a specific user.


### Export Content

Export content from the source site:

1. Export the site content using the [WordPress Importer](https://wordpress.org/plugins/wordpress-importer/). To run the export, navigate to "Tools &rarr; Export" in your site dashboard.

2. Export the site options using the [WP Options Importer](https://wordpress.org/plugins/options-importer/) plugin. The output should be a single `options.json` file.


### Prepare Import

1. Parse the exported [WordPress eXtended RSS or WXR](https://codex.wordpress.org/Tools_Export_Screen) into JSON files for site users, terms and posts:

	   wp replicator parse-wxr path/to/wxr/directory

   where `path/to/wxr/directory` is the path to the directory with all the XML files.

   All XML files `path/to/wxr/files/*.xml` are parsed and stored in the `path/to/wxr/directory/json` directory -- `users.json`, `terms.json` and `posts-*.json`.


### Import Content

Please note that you may need to specify `--url` for all commands if you're running WordPress multisite.

1. Empty the site content where you want to import the content:

	   wp site empty --yes

2. Import options:

	   wp replicator import-options "path/to/options.json"

   where `path/to/options.json` is the path to the exported options.

3. Import users:

	   wp replicator import-users "path/to/users.json"

   where `path/to/users.json` is the path the user list generated from the XML export.

4. Import taxonomies and terms:

	   wp replicator import-terms "path/to/terms.json"

   where `path/to/terms.json` is the path the term list generated from the XML export.

5. Import posts:

	   wp replicator import-posts "path/to/posts-*.json"


## Credits

Created by [Kaspars Dambis](https://kaspars.net).
