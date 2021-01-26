import "regenerator-runtime/runtime";
import ReactDOM from "react-dom";
import React from "react";
import tw, { GlobalStyles } from "twin.macro";
import { QueryClientProvider, useQuery } from "react-query";
import { request, gql } from "graphql-request";
import { queryClient } from "./cache";
import { useState, useEffect } from "react";

function useDebounce(value, delay) {
  // State and setters for debounced value
  const [debouncedValue, setDebouncedValue] = useState(value);

  useEffect(
    () => {
      // Update debounced value after delay
      const handler = setTimeout(() => {
        setDebouncedValue(value);
      }, delay);

      // Cancel the timeout if value changes (also on delay change or unmount)
      // This is how we prevent debounced value from updating if value is changed ...
      // .. within the delay period. Timeout gets cleared and restarted.
      return () => {
        clearTimeout(handler);
      };
    },
    [value, delay] // Only re-call effect if value or delay changes
  );

  return debouncedValue;
}

function useVendors({ search, relatedTo } = {}) {
  return useQuery(["vendors", search, relatedTo], async () => {
    return await request(
      "https://acrsupply.ddev.site/api",
      gql`
        query($search: String, $relatedTo: [QueryArgument]) {
          entries(
            section: "vendors"
            orderBy: "title"
            search: $search
            relatedTo: $relatedTo
          ) {
            id
            title
            slug
            postDate
          }
        }
      `,
      { ...(search ? { search } : {}), ...(relatedTo ? { relatedTo } : {}) }
    );
  });
}

function useVendorCategories() {
  return useQuery("vendorCategories", async () => {
    return await request(
      "https://acrsupply.ddev.site/api",
      gql`
        query {
          categories(group: "vendors") {
            id
            title
          }
        }
      `
    );
  });
}

function Vendors() {
  const [inputValue, setInputValue] = useState("");
  const search = useDebounce(inputValue, 500);

  const [relatedTo, setRelatedTo] = useState("");

  const { data } = useVendors({ search, relatedTo });
  const { data: categoriesData } = useVendorCategories();

  const isCategorySelected = (id) => id === relatedTo;
  const hasEntries = data?.entries?.length > 0;

  return (
    <div tw="mt-8">
      <h2 tw="text-2xl font-bold">Vendors</h2>
      <div tw="my-4">
        <div tw="w-1/3">
          <input
            value={inputValue}
            onChange={(e) => setInputValue(e.target.value)}
            placeholder="Search vendors..."
            tw="focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md px-4 py-2"
          />
        </div>
        <div tw="my-2">
          {relatedTo ? (
            <button
              onClick={() => setRelatedTo("")}
              tw="text-xs font-bold mr-2 inline-block border border-solid border-gray-200 px-2 leading-5 rounded bg-white hover:bg-gray-300 hover:text-black"
            >
              Clear
            </button>
          ) : (
            <span tw="text-xs font-bold mr-2 inline-block">Categories</span>
          )}
          {categoriesData?.categories?.map((category) => (
            <span
              key={category.id}
              onClick={() => setRelatedTo(category.id)}
              tw="cursor-pointer px-2 mr-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-200 text-gray-800"
              css={[
                isCategorySelected(category.id) &&
                  tw`bg-green-100 text-green-800`,
              ]}
            >
              {category.title}
            </span>
          ))}
        </div>
      </div>
      <div tw="grid gap-4 grid-cols-4">
        {hasEntries ? (
          data?.entries?.map((entry) => (
            <div key={entry.id}>
              <span>{entry.title}</span>
            </div>
          ))
        ) : (
          <div>
            <p>No vendors found.</p>
          </div>
        )}
      </div>
    </div>
  );
}

const domContainer = document.querySelector("#vendors-app");
ReactDOM.render(
  <QueryClientProvider client={queryClient}>
    <GlobalStyles />
    <Vendors />
  </QueryClientProvider>,
  domContainer
);
