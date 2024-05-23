# Expandable Searchbar

### Example Code
```dart
 ExpandableSearchbar(
            curve: Curves.linear,
            animationDuration: 500,
            height: 50,
            contentColor: Colors.white,
            backgroundColor: Colors.blue,
            width: MediaQuery.sizeOf(context).width / 2,
            onSearch: () {
              setState(() {
                searching = true;
              });
            },
            controller: searchController,
            hintText: 'Search...',
            onHide: () {
              searchController.clear();
            },
          ),
```

Simple usage:
</td>
<td>
<img  src="../gifs/search_in_action.gif"  alt="">
</td>
</tr>
</table>