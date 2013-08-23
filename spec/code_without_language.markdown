 This is an html block

```
    <table>
      <thead>
        <tr>
          <th>Column 1</th>
          <th>Column 2</th>
          <th>Column 3</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>Value 1</td>
          <td>Value 2</td>
          <td>Value 3</td>
        </tr>
        <tr>
          <td>Value 1a</td>
          <td>Value 2a</td>
          <td>Value 3a</td>
        </tr>
      </tbody>
    </table>
```

This is a ruby block

```
    # GET /blogs/1
    # GET /blogs/1.json
    def show
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @blog }
      end
    end
```

 